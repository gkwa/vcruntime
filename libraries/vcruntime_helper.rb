# https://blog.chef.io/2014/03/12/writing-libraries-in-chef-cookbooks/

module Vcruntime
  module Helper

    include Chef::Mixin::ShellOut

    def has_hotfix?(hotfix_id)
      cmd = shell_out!("#{ENV['WINDIR']}\\system32\\WindowsPowerShell\\v1.0\\powershell.exe -NoLogo \
	      -NonInteractive -NoProfile -ExecutionPolicy RemoteSigned Get-Hotfix -ID #{hotfix_id} \
	      -ErrorAction SilentlyContinue", {:returns => [0, 1]})
      cmd.stderr.empty? && (cmd.exitstatus == 0)
    end

    def clear_software_disribution_folder
      powershell_script 'Disable automatic proxy detection' do
	ignore_failure true
	code <<-EOH
	  # Restart Windws Update Service
	  # try suggestion from http://answers.microsoft.com/en-us/windows/forum/windows8_1-update/visual-c-2015-redistributable-error/ae9a0c2d-a23b-4dd7-ab6b-cbefb8908c99
	  get-service wuauserv | where {$_.status -eq 'running'} | stop-service -force -pass
	  set-location "c:\\windows"
	  rename-item "c:\\windows\\SoftwareDistribution" "c:\\windows\\SoftwareDistribution.bck"
	  start-service wuauserv
	EOH
      end
    end

    def disable_auto_proxy_detection
      powershell_script 'Disable automatic proxy detection' do
	ignore_failure true
	code <<-EOH
	  # Disable automatic proxy detection
	  (new-object System.Net.WebClient).DownloadFile('http://installer-bin.streambox.com/wget.exe','wget.exe')
	  .\wget.exe --no-verbose -N --no-check-certificate https://raw.githubusercontent.com/TaylorMonacelli/win_settings/master/settings.ps1 `
		   https://raw.githubusercontent.com/TaylorMonacelli/win_settings/master/include.ps1
	  .\settings.ps1 --proxydisable
	EOH
      end
    end

    def install_dependency

      hotfix_package_name = ::File.basename(node['KB2999226']['url'])
      Chef::Log.info "package_url=#{node['KB2999226']['url']}"
      require 'uri'
      uri = URI.parse(node['KB2999226']['url'])

      remote_file "#{Chef::Config[:file_cache_path]}\\#{hotfix_package_name}" do
	source node['KB2999226']['url']
	checksum node['KB2999226']['checksum']
	# FIXME: we are using this guard twice Get-Hotfix -ID KB2999226
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
	# FIXME: we are using this guard twice Get-Hotfix -ID KB2999226
	not_if { has_hotfix?('KB2999226') }
      end

    end
  end
end

Chef::Recipe.send(:include, Vcruntime::Helper)
