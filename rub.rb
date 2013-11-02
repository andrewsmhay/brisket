#!/usr/bin/env ruby

# Generate masscan configuration files

require 'rake'
require 'date'

if ARGV.size != 1 then
  puts "[-] Usage: ./rub.rb </home/scanner/conf/filename.conf>"
  exit
end

working_dir = "."
cmd = "/usr/local/sbin/masscan"
exclude_file = working_dir+"/conf/exclude.conf"
results_dir = working_dir+"/results/"
conf_dir = working_dir+"/conf/"
dir_date = Date.today.year.to_s+"/"+Date.today.month.to_s+"/"+Date.today.day.to_s+"/"
results_dir_date = results_dir + dir_date
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