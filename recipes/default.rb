# Cookbook Name:: puma
# Recipe:: default
#
# Copyright 2013,2014 Yousef Ourabi
#

puma_install do
  gem_bin_path node["puma"]["rubygems_location"]
end
