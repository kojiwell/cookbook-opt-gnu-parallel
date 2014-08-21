#
# Cookbook Name:: gnu-parallel
# Recipe:: default
# Author:: Koji Tanaka (<kj.tanaka@gmail.com>)
#
# Copyright 2014, FutureGrid, Indiana University
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

include_recipe 'build-essential'

directory node['gnu_parallel']['download_dir']

remote_file "#{node['gnu_parallel']['download_dir']}/parallel-#{node['gnu_parallel']['version']}.tar.bz2" do
  source node['gnu_parallel']['download_url']
  owner "root"
  group "root"
  mode "0644"
end

execute "untar_source" do
  user "root"
  cwd node['gnu_parallel']['download_dir']
  command "tar jxvf parallel-#{node['gnu_parallel']['version']}.tar.bz2"
  creates "parallel-#{node['gnu_parallel']['version']}"
end

bash "install_parallel" do
  user "root"
  cwd "#{node['gnu_parallel']['download_dir']}/parallel-#{node['gnu_parallel']['version']}"
  code <<-EOH
  ./configure --prefix=#{node['gnu_parallel']['prefix']}
  make
  make install
  EOH
  creates node['gnu_parallel']['prefix']
end
