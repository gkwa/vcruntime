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

Chef::Resource::PowershellScript.send(:include, Vcruntime::Helper)
Chef::Resource::RemoteFile.send(:include, Vcruntime::Helper)

include_recipe 'chrome' # temp for debug and ie8 sux

if node.attribute?('KB2999226') and !node['KB2999226']['url'].to_s.empty?
  clear_software_disribution_folder
  disable_auto_proxy_detection
  install_dependency
end

case node['kernel']['machine']
when 'x86_64'
  windows_package node['vcruntime']['vc14']['x64'][node['vcruntime']['vc14']['version']]['name'] do
    checksum node['vcruntime']['vc14']['x64'][node['vcruntime']['vc14']['version']]['sha256sum']
    source node['vcruntime']['vc14']['x64'][node['vcruntime']['vc14']['version']]['url']
    installer_type :custom
    returns [0, 42, 127, 5]
    options '/install /passive /norestart /log %TEMP%\vcredist_inst.log.txt'
  end
  windows_package node['vcruntime']['vc14']['x64'][node['vcruntime']['vc14']['version']]['name'] do
    checksum node['vcruntime']['vc14']['x64'][node['vcruntime']['vc14']['version']]['sha256sum']
    source node['vcruntime']['vc14']['x64'][node['vcruntime']['vc14']['version']]['url']
    installer_type :custom
    returns [0, 42, 127, 5]
    options '/repair /passive /norestart /log %TEMP%\vcredist_rep.log.txt'
  end
when /i[3-6]86/
  windows_package node['vcruntime']['vc14']['x86'][node['vcruntime']['vc14']['version']]['name'] do
    checksum node['vcruntime']['vc14']['x86'][node['vcruntime']['vc14']['version']]['sha256sum']
    source node['vcruntime']['vc14']['x86'][node['vcruntime']['vc14']['version']]['url']
    installer_type :custom
    returns [0, 42, 127, 5]
    options '/install /passive /norestart /log %TEMP%\vcredist_inst.log.txt'
  end
  windows_package node['vcruntime']['vc14']['x86'][node['vcruntime']['vc14']['version']]['name'] do
    checksum node['vcruntime']['vc14']['x86'][node['vcruntime']['vc14']['version']]['sha256sum']
    source node['vcruntime']['vc14']['x86'][node['vcruntime']['vc14']['version']]['url']
    installer_type :custom
    returns [0, 42, 127, 5]
    options '/repair /passive /norestart /log %TEMP%\vcredist_rep.log.txt'
  end
end
