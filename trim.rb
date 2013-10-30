#!/usr/bin/env ruby
#Used to generate masscan configuration files
#
require 'rubygems'
require 'rake'
require 'date'
require 'trollop'

## Shell commands
#http://trollop.rubyforge.org/

working_dir = "/home/scanner"
remote_ports = 	"22,23,3389"
app_ports = 	",21,80,139,443,445,1434,1521"
rate = "1337" #restriction by the service provider is 4000/second
rate_cmd = "--rate " + rate
cmd = "/usr/local/sbin/masscan"
exclude_file = working_dir+"/masscan/data/exclude.conf"
results_dir = working_dir+"/results/"
data_dir = working_dir+"/data/"
include_file_cmd = " --includefile " + data_dir
conf_dir = working_dir+"/conf/"
dir_date = Date.today.year.to_s+"/"+Date.today.month.to_s+"/"+Date.today.day.to_s+"/"
results_dir_date = results_dir + dir_date
results_out = "-oX " + results_dir_date

## Create a command line switch for each type of region
#
## Create the latest conf files
Dir.foreach(data_dir) do |item|
  next if item == '.' or item == '..'
  # do work on real items
  item_dir = conf_dir + item.gsub(/(.ip)/, '.conf')
  item_xml = item.gsub(/(.ip)/, '.xml')
  #puts cmd + " -p" + remote_ports + include_file_cmd + item + " " + rate_cmd + " " + results_out + item_xml + " --echo > " + item_dir
  system(cmd + " -p" + remote_ports+app_ports + include_file_cmd + item + " " + rate_cmd + " " + results_out + item_xml + " --echo > " + item_dir)
end