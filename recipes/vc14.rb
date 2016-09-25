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

# FIXME: move this hotfix installer to helper?

hotfix_package_name = ::File.basename(node['KB2999226']['url'])
Chef::Log.error "package_url=#{node['KB2999226']['url']}"
require 'uri'
uri = URI.parse(node['KB2999226']['url'])

remote_file "#{Chef::Config[:file_cache_path]}\\#{hotfix_package_name}" do
  source node['KB2999226']['url']
  checksum node['KB2999226']['checksum']
  # FIXME: we're using this guard twice Get-Hotfix -ID KB2999226
  not_if "#{ENV['WINDIR']}\\system32\\WindowsPowerShell\\v1.0\\powershell.exe -NoLogo \
	-NonInteractive -NoProfile -ExecutionPolicy RemoteSigned Get-Hotfix -ID KB2999226 \
	-ErrorAction SilentlyContinue"
end

basename = File.basename(uri.path, '.msu')
cabfile="#{basename}.cab"
Chef::Log.error "cabfile=#{cabfile}"

powershell_script 'Install KB2999226' do
  code <<-EOH
  # https://goo.gl/xt3Asq
  mkdir -Force "#{Chef::Config[:file_cache_path]}\\#{basename}"
  expand -f:* "#{Chef::Config[:file_cache_path]}\\#{hotfix_package_name}" "#{Chef::Config[:file_cache_path]}\\#{basename}"
  dism.exe /Online /Add-Package /PackagePath:"#{Chef::Config[:file_cache_path]}\\#{basename}\\#{cabfile}"
  EOH
  # FIXME: we're using this guard twice Get-Hotfix -ID KB2999226
  not_if "#{ENV['WINDIR']}\\system32\\WindowsPowerShell\\v1.0\\powershell.exe -NoLogo \
	-NonInteractive -NoProfile -ExecutionPolicy RemoteSigned Get-Hotfix -ID KB2999226 \
	-ErrorAction SilentlyContinue"
end

case node['kernel']['machine']
when 'x86_64'
  windows_package node['vcruntime']['vc14']['x64'][node['vcruntime']['vc14']['version']]['name'] do
    checksum node['vcruntime']['vc14']['x64'][node['vcruntime']['vc14']['version']]['sha256sum']
    source node['vcruntime']['vc14']['x64'][node['vcruntime']['vc14']['version']]['url']
    installer_type :custom
    options '/q'
  end
when /i[3-6]86/
  windows_package node['vcruntime']['vc14']['x86'][node['vcruntime']['vc14']['version']]['name'] do
    checksum node['vcruntime']['vc14']['x86'][node['vcruntime']['vc14']['version']]['sha256sum']
    source node['vcruntime']['vc14']['x86'][node['vcruntime']['vc14']['version']]['url']
    installer_type :custom
    options '/q'
  end
end
