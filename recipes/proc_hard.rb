# Cookbook Name:: stig
# Recipe:: proc_hard
# Author: David Blodgett <dblodgett@usgs.gov>, Ivan Suftin <isuftin@usgs.gov>
#
# Description: Updates sysctl policies using the third-party sysctl cookbook
# and parameters specific to that cookbook coming from the default attributes.

#############################################################################
# BEGIN - Configure max_login default to 10 or less per STIG - V-72217
#############################################################################
# Initial value from attributes.rb - default['stig']['limits_conf']['max_logins']
# Override with Databag Values, if present. Some Customers require 5 or 3 versus
# 10 as value. This databag may not exist so we need to check for Exceptions
# and catch them if it does not exist or is not digits
package_data = begin
            Chef::DataBagItem.load('stig', 'packages')
          rescue Net::HTTPServerException, Chef::Exceptions::InvalidDataBagPath
            [] # empty array for length comparison
          end
# Just because the DataBag exists does not mean that the nested key here will
# exist, so lets check for the nil exception and catch that too. If it does
# exist and have an all digit value, we will override the default value.
all_numbers_re = /^\d+$/
unless package_data.empty?
  node.default['stig']['limits_conf']['max_logins'] = begin
    package_data[node.chef_environment]['limits_conf']['max_logins'].empty? || !all_numbers_re.match(package_data[node.chef_environment]['limits_conf']['max_logins']) ? node['stig']['limits_conf']['max_logins'] : package_data[node.chef_environment]['limits_conf']['max_logins']
  rescue NoMethodError
    node['stig']['limits_conf']['max_logins']
  end
end

# Iterate through and figure out if we have a maxlogins setting
# if so, update it with the value determine from DataBag logic above
# value may remain the same but just end up derived from the DataBag.
maxlogins_re = /^maxlogins (\d+)+/
level_matched = nil
level_counter = 0
node['stig']['limits'].each do |limit|
  limit.each do |lk, lv| 
      unless lv.empty? 
        lv.each do |fdk, fdv| 
          # Ensure we are dealing with "* hard maxlogins XX"
          if lk =~ /\*/ && fdk =~ /hard/ && maxlogins_re.match(fdv)
              node.default['stig']['limits'][level_counter][lk][fdk] = "maxlogins #{node['stig']['limits_conf']['max_logins']}"
          end 
        end  
      end 
  end
  level_counter += 1
end
#############################################################################
# END - Configure max_login default to 10 or less per STIG - V-72217
#############################################################################

template '/etc/security/limits.conf' do
  source 'limits.conf.erb'
  owner 'root'
  group 'root'
  mode 0o644
end

package 'apport' do
  action :remove
  only_if { %w[debian ubuntu].include? node['platform'] }
end

package 'whoopsie' do
  action :remove
  only_if { %w[debian ubuntu].include? node['platform'] }
end

node['sysctl']['params'].each do |param, value|
  sysctl_param param do
    key param
    value value
    only_if "sysctl -n #{param}"
  end
end
