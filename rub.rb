#!/usr/bin/env ruby
#Used to generate masscan configuration files
#
require 'rubygems'
require 'rake'
require 'date'
require 'trollop'

## Shell commands
#http://trollop.rubyforge.org/

if ARGV.size != 1 then
  puts "n[-] Usage: ./rub.rb </home/scanner/conf/filename.conf>"
  exit
end

working_dir = "/home/scanner"
#rate = "1337" #restriction by the service provider is 4000/second
#rate_cmd = "--rate " + rate
cmd = "/usr/local/sbin/masscan"
exclude_file = working_dir+"/masscan/data/exclude.conf"
results_dir = working_dir+"/results/"
#data_dir = working_dir+"/data/"
#include_file_cmd = " --includefile " + data_dir
conf_dir = working_dir+"/conf/"
dir_date = Date.today.year.to_s+"/"+Date.today.month.to_s+"/"+Date.today.day.to_s+"/"
results_dir_date = results_dir + dir_date
#results_out = "-oX " + results_dir_date + "aws_gov.xml"
confpath = conf_dir + ARGV[0]
 
## Create directory for current day (if it doesn't already exist)
if File.directory?(dir_date)
	puts "The directory" + results_dir_date + " already exists, no need to create it."
else
	FileUtils.mkdir_p results_dir_date
	puts "Created " + results_dir_date
end
## Run scan
puts "Beginning scan..."
system(cmd + " -c " + confpath + " --banners --excludefile " + exclude_file)

## bzip2 the xml file
# https://github.com/brianmario/bzip2-ruby
##