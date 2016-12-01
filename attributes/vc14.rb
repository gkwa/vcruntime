#
# Author:: Julian C. Dunn (<jdunn@chef.io>)
# Cookbook Name:: vcruntime
# Attributes:: vc12
# Copyright 2014-2015, Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

https://download.microsoft.com/download/9/3/E/93E0745A-EAE9-4B5A-B50C-012F2D3B6659/Windows8-RT-KB2999226-x64.msu


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
  elsif win_version.windows_2008_r2?
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
  elsif windows_server_2012_r2?
    case node['kernel']['machine']
    when /i[3-6]86/
      default['KB2999226']['url'] = ''
      default['KB2999226']['checksum'] = ''
    when 'x86_64'
      default['KB2999226']['url'] = 'https://download.microsoft.com/download/D/1/3/D13E3150-3BB2-4B22-9D8A-47EE2D609FFF/Windows8.1-KB2999226-x64.msu'
      default['KB2999226']['checksum'] = '9f707096c7d279ed4bc2a40ba695efac69c20406e0ca97e2b3e08443c6381d15'
    end
  elsif windows_server_2012?
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
  elsif win_version.windows_vista? || win_version.windows_2008?
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

default['vcruntime']['vc14']['x86']['14.0.23026']['url']         = 'https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x86.exe'
default['vcruntime']['vc14']['x86']['14.0.23026']['sha256sum']   = 'fdd1e1f0dcae2d0aa0720895eff33b927d13076e64464bb7c7e5843b7667cd14'
default['vcruntime']['vc14']['x86']['14.0.23026']['name']        = 'Microsoft Visual C++ 2015 Redistributable (x86) - version'
default['vcruntime']['vc14']['x64']['14.0.23026']['url']         = 'https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe'
default['vcruntime']['vc14']['x64']['14.0.23026']['sha256sum']   = '5eea714e1f22f1875c1cb7b1738b0c0b1f02aec5ecb95f0fdb1c5171c6cd93a3'
default['vcruntime']['vc14']['x64']['14.0.23026']['name']        = 'Microsoft Visual C++ 2015 Redistributable (x64) - version'

default['vcruntime']['vc14']['x86']['14.0.24212']['url']         = 'https://download.microsoft.com/download/9/A/2/9A2A7E36-A8AF-46C0-8A78-A5EB111EEFE2/vc_redist.x86.exe'
default['vcruntime']['vc14']['x86']['14.0.24212']['sha256sum']   = 'dafb8b5f4b46bfaf7faa1d0ad05211f5c9855f0005cd603f8b5037b6a708d6b6'
default['vcruntime']['vc14']['x86']['14.0.24212']['name']        = 'Microsoft Visual C++ 2015 Redistributable (x86) - version'
default['vcruntime']['vc14']['x64']['14.0.24212']['url']         = 'https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x64.exe'
default['vcruntime']['vc14']['x64']['14.0.24212']['sha256sum']   = 'da66717784c192f1004e856bbcf7b3e13b7bf3ea45932c48e4c9b9a50ca80965'
default['vcruntime']['vc14']['x64']['14.0.24212']['name']        = 'Microsoft Visual C++ 2015 Redistributable (x64) - version'

default['vcruntime']['vc14']['x86']['14.0.24215']['url']         = 'https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x86.exe'
default['vcruntime']['vc14']['x86']['14.0.24215']['sha256sum']   = '12a69af8623d70026690ba14139bf3793cc76c865759cad301b207c1793063ed'
default['vcruntime']['vc14']['x86']['14.0.24215']['name']        = 'Microsoft Visual C++ 2015 Redistributable (x86) - version'
default['vcruntime']['vc14']['x64']['14.0.24215']['url']         = 'https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x64.exe'
default['vcruntime']['vc14']['x64']['14.0.24215']['sha256sum']   = 'da66717784c192f1004e856bbcf7b3e13b7bf3ea45932c48e4c9b9a50ca80965'
default['vcruntime']['vc14']['x64']['14.0.24215']['name']        = 'Microsoft Visual C++ 2015 Redistributable (x64) - version'

default['vcruntime']['vc14']['x86']['14.0.24215.1']['url']       = 'https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x86.exe'
default['vcruntime']['vc14']['x86']['14.0.24215.1']['sha256sum'] = '12a69af8623d70026690ba14139bf3793cc76c865759cad301b207c1793063ed'
default['vcruntime']['vc14']['x86']['14.0.24215.1']['name']      = 'Microsoft Visual C++ 2015 Redistributable (x86) - version'
default['vcruntime']['vc14']['x64']['14.0.24215.1']['url']       = 'https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x64.exe'
default['vcruntime']['vc14']['x64']['14.0.24215.1']['sha256sum'] = 'da66717784c192f1004e856bbcf7b3e13b7bf3ea45932c48e4c9b9a50ca80965'
default['vcruntime']['vc14']['x64']['14.0.24215.1']['name']      = 'Microsoft Visual C++ 2015 Redistributable (x64) - version'

default['vcruntime']['vc14']['version']                          = '14.0.24215.1'
