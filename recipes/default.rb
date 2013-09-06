# Cookbook Name:: puma
# Recipe:: default
#
# Copyright 2013, Yousef Ourabi
#

gem_package 'bundler' do
  version "#{node.puma[:bundler_version]}"
  gem_binary "#{node.puma[:rubygems_location]}"  
  options '--no-ri --no-rdoc'
end

gem_package 'puma' do
  action :install
  version "#{node.puma[:version]}"
end
