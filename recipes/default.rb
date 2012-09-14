#
# Cookbook Name:: capistrano
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# These are the directories capistrano needs
directories = [
                "#{node[:capistrano][:root]}",
                "#{node[:capistrano][:root]}/releases",
                "#{node[:capistrano][:root]}/shared",
                "#{node[:capistrano][:root]}/shared/log",
                "#{node[:capistrano][:root]}/shared/pids",
                "#{node[:capistrano][:root]}/shared/system"
              ]

# Add any additional paths
default[:capistrano][:additional_paths].each { |path| directories << "#{node[:capistrano][:root]}/#{path}" }

username = node[:capistrano][:user]

# Get the group of our user
user_resource = user(username)
owner_group = user_resource.group

directories.each do |dir|
  directory(dir) do
    owner(username)
    group(owner_group)
    mode "0755"
  end
end