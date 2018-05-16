#
# Cookbook Name:: stig
# Recipe:: inittab
# Author: Craig Poma <cpoma@mitre.org>
#
# Description: This cookbook password protects Linux single user mode.

platform = node['platform']
major_version = node['platform_version'][0, 1].to_i

template '/etc/inittab' do
  source  'etc_inittab.erb'
  owner   'root'
  group   'root'
  mode    '0644'
  only_if { %w[rhel fedora centos redhat].include? platform }
  only_if { major_version < 7 }
end
