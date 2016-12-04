# https://blog.chef.io/2014/03/12/writing-libraries-in-chef-cookbooks/

module Vcruntime
  module Helper

    include Chef::Mixin::ShellOut

    def set_patch_url
      if node['platform_family'] == 'windows'
        require 'chef/win32/version'
        win_version = Chef::ReservedNames::Win32::Version.new
        if win_version.windows_7?
          case node['kernel']['machine']
          when /i[3-6]86/
            default['KB2999226']['url'] = 'https://download.microsoft.com/download/4/F/E/4FE73868-5EDD-4B47-8B33-CE1BB7B2B16A/Windows6.1-KB2999226-x86.msu'
            default['KB2999226']['checksum'] = '909e76c81ef0eb176144b253ddffe7a8fdfacebfaa15e97def003d2262fbf084'
          when 'x86_64'
            default['KB2999226']['url'] = 'https://download.microsoft.com/download/1/1/5/11565A9A-EA09-4F0A-A57E-520D5D138140/Windows6.1-KB2999226-x64.msu'
            default['KB2999226']['checksum'] = '43234d2986ca9b0de75d5183977964d161a8395c3396279ddfc9b20698e5bc34'
          end
        elsif win_version.windows_server_2008_r2?
          case node['kernel']['machine']
          when /i[3-6]86/
            default['KB2999226']['url'] = ''
            default['KB2999226']['checksum'] = ''
          when 'x86_64'
            default['KB2999226']['url'] = 'https://download.microsoft.com/download/F/1/3/F13BEC9A-8FC6-4489-9D6A-F84BDC9496FE/Windows6.1-KB2999226-x64.msu'
            default['KB2999226']['checksum'] = '43234d2986ca9b0de75d5183977964d161a8395c3396279ddfc9b20698e5bc34'
          end
        elsif win_version.windows_8?
          case node['kernel']['machine']
          when /i[3-6]86/
            default['KB2999226']['url'] = 'https://download.microsoft.com/download/1/E/8/1E8AFE90-5217-464D-9292-7D0B95A56CE4/Windows8-RT-KB2999226-x86.msu'
            default['KB2999226']['checksum'] = '0f36750fbb06fee23131f68b4d0943841eed24730ec1d5d77dedc41d359be88d'
          when 'x86_64'
            default['KB2999226']['url'] = 'https://download.microsoft.com/download/A/C/1/AC15393F-A6E6-469B-B222-C44B3BB6ECCC/Windows8-RT-KB2999226-x64.msu'
            default['KB2999226']['checksum'] = '50cae25da33fa950222d1a803e42567291eb7feb087fa119b1c97fe9d41cd9f8'
          end
        elsif win_version.windows_server_2012_r2?
          case node['kernel']['machine']
          when /i[3-6]86/
            default['KB2999226']['url'] = ''
            default['KB2999226']['checksum'] = ''
          when 'x86_64'
            default['KB2999226']['url'] = 'https://download.microsoft.com/download/D/1/3/D13E3150-3BB2-4B22-9D8A-47EE2D609FFF/Windows8.1-KB2999226-x64.msu'
            default['KB2999226']['checksum'] = '9f707096c7d279ed4bc2a40ba695efac69c20406e0ca97e2b3e08443c6381d15'
          end
        elsif win_version.windows_server_2012?
          case node['kernel']['machine']
          when /i[3-6]86/
            default['KB2999226']['url'] = ''
            default['KB2999226']['checksum'] = ''
          when 'x86_64'
            default['KB2999226']['url'] = 'https://download.microsoft.com/download/9/3/E/93E0745A-EAE9-4B5A-B50C-012F2D3B6659/Windows8-RT-KB2999226-x64.msu'
            default['KB2999226']['checksum'] = '50cae25da33fa950222d1a803e42567291eb7feb087fa119b1c97fe9d41cd9f8'
          end
        elsif win_version.windows_8_1?
          case node['kernel']['machine']
          when /i[3-6]86/
            default['KB2999226']['url'] = 'https://download.microsoft.com/download/E/4/6/E4694323-8290-4A08-82DB-81F2EB9452C2/Windows8.1-KB2999226-x86.msu'
            default['KB2999226']['checksum'] = 'b83251219c5390536b02bebaf5e43a6f13381ce1db43e76483bce07c4bcf877b'
          when 'x86_64'
            default['KB2999226']['url'] = 'https://download.microsoft.com/download/9/6/F/96FD0525-3DDF-423D-8845-5F92F4A6883E/Windows8.1-KB2999226-x64.msu'
            default['KB2999226']['checksum'] = '9f707096c7d279ed4bc2a40ba695efac69c20406e0ca97e2b3e08443c6381d15'
          end
        elsif win_version.windows_vista? || win_version.windows_server_2008?
          case node['kernel']['machine']
          when /i[3-6]86/
            default['KB2999226']['url'] = 'https://download.microsoft.com/download/D/8/3/D838D576-232C-4C17-A402-75913F27113B/Windows6.0-KB2999226-x86.msu'
            default['KB2999226']['checksum'] = 'ae380f63bf4e8700ada686406b04b01230a339b09edf7819814a4c0bf4ab72e1'
          when 'x86_64'
            default['KB2999226']['url'] = 'https://download.microsoft.com/download/5/4/E/54E27BE2-CFB2-4FC9-AB03-C39302CA68A0/Windows6.0-KB2999226-x64.msu'
            default['KB2999226']['checksum'] = '10069de7315ca3f405e2579846af5dab3089a8496ae4c1ab61763480f43a05a8'
          end
        elsif win_version.windows_vista?
          case node['kernel']['machine']
          when /i[3-6]86/
            default['KB2999226']['url'] = 'https://download.microsoft.com/download/B/5/7/B5757251-DAB0-4E23-AA46-ABC233FDB90E/Windows6.0-KB2999226-x86.msu'
            default['KB2999226']['checksum'] = 'ae380f63bf4e8700ada686406b04b01230a339b09edf7819814a4c0bf4ab72e1'
          when 'x86_64'
            default['KB2999226']['url'] = 'https://download.microsoft.com/download/A/7/A/A7A70B17-ADF9-4FC3-A722-69FA89B79756/Windows6.0-KB2999226-x64.msu'
            default['KB2999226']['checksum'] = '10069de7315ca3f405e2579846af5dab3089a8496ae4c1ab61763480f43a05a8'
          end
        end
      end
    end

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
