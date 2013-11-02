#!/usr/bin/env ruby

require 'rake'
require 'date'

working_dir = "."
remote_ports = 	"22,23,3389"
app_ports = 	"21,139,445"
web_ports =		"80,443,8080"
db_ports =		"1434,1521,3306,5432"
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
opt_sel = ['remote', 'apps', 'web', 'db', 'all']
opt_sel_err = "[-] Usage: ./trim.rb <remote|apps|web|db|all>"

commands = []
ARGV.each {|arg| commands << arg}
## Create the latest conf files
if ARGV[1] == opt_sel[0]
elsif ARGV[1] == opt_sel[1]
	Dir.foreach(data_dir) do |item|
		next if item == '.' or item == '..'
  		item_dir = conf_dir + item.gsub(/(.ip)/, '.conf')
  		item_xml = item.gsub(/(.ip)/, '.xml')
  		system(cmd + " -p" + remote_ports + include_file_cmd + item + " " + rate_cmd + " " + results_out + item_xml + " --echo > " + item_dir)
	end
elsif ARGV[1] == opt_sel[2]
	Dir.foreach(data_dir) do |item|
		next if item == '.' or item == '..'
  		item_dir = conf_dir + item.gsub(/(.ip)/, '.conf')
  		item_xml = item.gsub(/(.ip)/, '.xml')
  		system(cmd + " -p" + app_ports + include_file_cmd + item + " " + rate_cmd + " " + results_out + item_xml + " --echo > " + item_dir)
	end	
elsif ARGV[1] == opt_sel[3]
	Dir.foreach(data_dir) do |item|
		next if item == '.' or item == '..'
  		item_dir = conf_dir + item.gsub(/(.ip)/, '.conf')
  		item_xml = item.gsub(/(.ip)/, '.xml')
  		system(cmd + " -p" + web_ports + include_file_cmd + item + " " + rate_cmd + " " + results_out + item_xml + " --echo > " + item_dir)
	end	
elsif ARGV[1] == opt_sel[4]
	Dir.foreach(data_dir) do |item|
		next if item == '.' or item == '..'
  		item_dir = conf_dir + item.gsub(/(.ip)/, '.conf')
  		item_xml = item.gsub(/(.ip)/, '.xml')
  		system(cmd + " -p" + db_ports + include_file_cmd + item + " " + rate_cmd + " " + results_out + item_xml + " --echo > " + item_dir)
	end	
elsif ARGV[1] == opt_sel[5]
	Dir.foreach(data_dir) do |item|
		next if item == '.' or item == '..'
  		item_dir = conf_dir + item.gsub(/(.ip)/, '.conf')
  		item_xml = item.gsub(/(.ip)/, '.xml')
  		system(cmd + " -p" + remote_ports + "," + app_ports + "," + web_ports + "," + db_ports + include_file_cmd + item + " " + rate_cmd + " " + results_out + item_xml + " --echo > " + item_dir)
	end
else puts opt_sel_err
end

