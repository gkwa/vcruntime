#
# Author:: Yvo van Doorn (<yvo@chef.io>)
# Cookbook Name:: vcruntime
# Recipe:: vc14
#
# Copyright 2013-2015, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

Chef::Resource::RemoteFile.send(:include, Vcruntime::Helper)
Chef::Resource::PowershellScript.send(:include, Vcruntime::Helper)

def install_dependency
  hotfix_package_name = ::File.basename(node['KB2999226']['url'])
  Chef::Log.info "package_url=#{node['KB2999226']['url']}"
  require 'uri'
  uri = URI.parse(node['KB2999226']['url'])

  remote_file "#{Chef::Config[:file_cache_path]}\\#{hotfix_package_name}" do
    source node['KB2999226']['url']
    checksum node['KB2999226']['checksum']
    # FIXME: we're using this guard twice Get-Hotfix -ID KB2999226
    not_if { has_hotfix?('KB2999226') }
  end

  basename = File.basename(uri.path, '.msu')
  cabfile="#{basename}.cab"
  Chef::Log.info "cabfile=#{cabfile}"

  powershell_script 'Install KB2999226' do
    code <<-EOH
  # https://goo.gl/xt3Asq
  mkdir -Force "#{Chef::Config[:file_cache_path]}\\#{basename}"
  expand -f:* "#{Chef::Config[:file_cache_path]}\\#{hotfix_package_name}" "#{Chef::Config[:file_cache_path]}\\#{basename}"
  $ErrorActionPreference = 'SilentlyContinue'
  dism.exe /Online /Add-Package /PackagePath:"#{Chef::Config[:file_cache_path]}\\#{basename}\\#{cabfile}"
  # Error 775: https://msdn.microsoft.com/en-us/library/windows/desktop/ms681388(v=vs.85).aspx
  # Error 1151: The specified package is not applicable to this image.
  if(-not($LastExitCode -eq 775 -or $LastExitCode -eq 1151)){ throw }
    EOH
    # FIXME
    ignore_failure true # fails on mwrock/Windows2012R2
    # FIXME: we're using this guard twice Get-Hotfix -ID KB2999226
    not_if { has_hotfix?('KB2999226') }
  end
end

include_recipe 'chrome'

# try suggestion from http://answers.microsoft.com/en-us/windows/forum/windows8_1-update/visual-c-2015-redistributable-error/ae9a0c2d-a23b-4dd7-ab6b-cbefb8908c99
powershell_script 'Disable automatic proxy detection' do
  code <<-EOH1
get-service wuauserv | where {$_.status -eq 'running'} | stop-service -pass
set-location c:\windows
rename-item c:\windows\SoftwareDistribution c:\windows\SoftwareDistribution.bck
start-service wuauserv
  EOH1
end

powershell_script 'Disable automatic proxy detection' do
  code <<-EOH
function Disable-AutomaticallyDetectProxySettings
{
    # Read connection settings from Internet Explorer.
    $regKeyPath = "HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Connections\\"
    $conSet = $(Get-ItemProperty $regKeyPath).DefaultConnectionSettings
 
    # Index into DefaultConnectionSettings where the relevant flag resides.
    $flagIndex = 8
 
    # Bit inside the relevant flag which indicates whether or not to enable automatically detect proxy settings.
    $autoProxyFlag = 8
 
    if ($($conSet[$flagIndex] -band $autoProxyFlag) -eq $autoProxyFlag)
    {
        # 'Automatically detect proxy settings' was enabled, adding one disables it.
        Write-Host "Disabling 'Automatically detect proxy settings'."
        $mask = -bnot $autoProxyFlag
        $conSet[$flagIndex] = $conSet[$flagIndex] -band $mask
        $conSet[4]++
        Set-ItemProperty -Path $regKeyPath -Name DefaultConnectionSettings -Value $conSet
    }
    
    $conSet = $(Get-ItemProperty $regKeyPath).DefaultConnectionSettings
    if ($($conSet[$flagIndex] -band $autoProxyFlag) -ne $autoProxyFlag)
    {
    	Write-Host "'Automatically detect proxy settings' is disabled."
    }
}

$job = Start-Job -ScriptBlock { Start-Process "C:\\Program Files\\Internet Explorer\\iexplore.exe" -Wait -PassThru }
Start-Sleep -Seconds 5
Stop-Job -Id $job.Id

Disable-AutomaticallyDetectProxySettings

Set-Itemproperty "HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Connections" -Name ProxyEnable -Value 0
  EOH
end

if node.attribute?('KB2999226') and !node['KB2999226']['url'].to_s.empty?
  install_dependency
end

case node['kernel']['machine']
when 'x86_64'
  windows_package node['vcruntime']['vc14']['x64'][node['vcruntime']['vc14']['version']]['name'] do
    checksum node['vcruntime']['vc14']['x64'][node['vcruntime']['vc14']['version']]['sha256sum']
    source node['vcruntime']['vc14']['x64'][node['vcruntime']['vc14']['version']]['url']
    installer_type :custom
    returns [0, 42, 127, 5]
    options '/install /quiet /norestart /log %TEMP%\vcredist_inst.log.txt'
  end
  windows_package node['vcruntime']['vc14']['x64'][node['vcruntime']['vc14']['version']]['name'] do
    checksum node['vcruntime']['vc14']['x64'][node['vcruntime']['vc14']['version']]['sha256sum']
    source node['vcruntime']['vc14']['x64'][node['vcruntime']['vc14']['version']]['url']
    installer_type :custom
    returns [0, 42, 127, 5]
    options '/repiar /quiet /norestart /log %TEMP%\vcredist_rep.log.txt'
  end
when /i[3-6]86/
  windows_package node['vcruntime']['vc14']['x86'][node['vcruntime']['vc14']['version']]['name'] do
    checksum node['vcruntime']['vc14']['x86'][node['vcruntime']['vc14']['version']]['sha256sum']
    source node['vcruntime']['vc14']['x86'][node['vcruntime']['vc14']['version']]['url']
    installer_type :custom
    returns [0, 42, 127, 5]
    options '/install /quiet /norestart /log %TEMP%\vcredist_inst.log.txt'
  end
  windows_package node['vcruntime']['vc14']['x86'][node['vcruntime']['vc14']['version']]['name'] do
    checksum node['vcruntime']['vc14']['x86'][node['vcruntime']['vc14']['version']]['sha256sum']
    source node['vcruntime']['vc14']['x86'][node['vcruntime']['vc14']['version']]['url']
    installer_type :custom
    returns [0, 42, 127, 5]
    options '/repiar /quiet /norestart /log %TEMP%\vcredist_rep.log.txt'
  end
end
