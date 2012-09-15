#
# Cookbook Name:: capistrano
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# These are the paths capistrano needs
paths = [
  "#{node[:capistrano][:root_path]}",
  "#{node[:capistrano][:root_path]}/releases",
  "#{node[:capistrano][:root_path]}/shared",
  "#{node[:capistrano][:root_path]}/shared/log",
  "#{node[:capistrano][:root_path]}/shared/pids",
  "#{node[:capistrano][:root_path]}/shared/system"
]

# Add any additional directories
node[:capistrano][:additional_directories].each { |path| paths << "#{node[:capistrano][:root_path]}/#{path}" }

username = node[:capistrano][:user]

# Get the group of our user
user_resource = user(username)
owner_group = user_resource.group

paths.each do |dir|
  directory(dir) do
    owner(username)
    group(owner_group)
    mode "0755"
  end
end