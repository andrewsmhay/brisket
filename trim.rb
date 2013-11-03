#!/usr/bin/env ruby

require 'rake'
require 'date'

working_dir = "/home/scanner/brisket/"
remote_ports = 	"22,23,3389,5900"
app_ports = 	"21,69,53,389"
ms_ports =    "135,139,445"
mail_ports =  "25,110,995,993,465"
web_ports =		"80,443,8080"
db_ports =		"1433,1521,3306,5432"
# IRC, tor, tcp syslog, DNP3 (SCADA networks)
special_ports = "6667,9050,1514,20000"
rate = "2337" #restriction by the service provider is 4000/second
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
opt_sel = ['remote', 'apps', 'web', 'db','special', 'ms', 'mail', 'all']
opt_sel_err = "[-] Usage: ./trim.rb <remote|apps|web|db|all>"
timenow = Time.new
conf_txt = "[+] Configuration files successfully generated for "+ARGV[0]+" ports at "+timenow.inspect +"."

commands = []
ARGV.each {|arg| commands << arg}
## Create the latest conf files
if ARGV[0] == opt_sel[0]
	Dir.foreach(data_dir) do |item|
		next if item == '.' or item == '..'
  		item_dir = conf_dir + item.gsub(/(.ip)/, '.conf')
  		item_xml = item.gsub(/(.ip)/, '.xml')
  		system(cmd + " -p" + remote_ports + include_file_cmd + item + " " + rate_cmd + " " + results_out + item_xml + " --echo > " + item_dir)
	end
	puts conf_txt
elsif ARGV[0] == opt_sel[1]
	Dir.foreach(data_dir) do |item|
		next if item == '.' or item == '..'
  		item_dir = conf_dir + item.gsub(/(.ip)/, '.conf')
  		item_xml = item.gsub(/(.ip)/, '.xml')
  		system(cmd + " -p" + app_ports + include_file_cmd + item + " " + rate_cmd + " " + results_out + item_xml + " --echo > " + item_dir)
	end	
	puts conf_txt	
elsif ARGV[0] == opt_sel[2]
	Dir.foreach(data_dir) do |item|
		next if item == '.' or item == '..'
  		item_dir = conf_dir + item.gsub(/(.ip)/, '.conf')
  		item_xml = item.gsub(/(.ip)/, '.xml')
  		system(cmd + " -p" + web_ports + include_file_cmd + item + " " + rate_cmd + " " + results_out + item_xml + " --echo > " + item_dir)
	end	
	puts conf_txt	
elsif ARGV[0] == opt_sel[3]
	Dir.foreach(data_dir) do |item|
		next if item == '.' or item == '..'
  		item_dir = conf_dir + item.gsub(/(.ip)/, '.conf')
  		item_xml = item.gsub(/(.ip)/, '.xml')
  		system(cmd + " -p" + db_ports + include_file_cmd + item + " " + rate_cmd + " " + results_out + item_xml + " --echo > " + item_dir)
	end	
	puts conf_txt	
elsif ARGV[0] == opt_sel[4]
  Dir.foreach(data_dir) do |item|
    next if item == '.' or item == '..'
      item_dir = conf_dir + item.gsub(/(.ip)/, '.conf')
      item_xml = item.gsub(/(.ip)/, '.xml')
      system(cmd + " -p" + special_ports + include_file_cmd + item + " " + rate_cmd + " " + results_out + item_xml + " --echo > " + item_dir)
  end
  puts conf_txt
elsif ARGV[0] == opt_sel[5]
  Dir.foreach(data_dir) do |item|
    next if item == '.' or item == '..'
      item_dir = conf_dir + item.gsub(/(.ip)/, '.conf')
      item_xml = item.gsub(/(.ip)/, '.xml')
      system(cmd + " -p" + ms_ports + include_file_cmd + item + " " + rate_cmd + " " + results_out + item_xml + " --echo > " + item_dir)
  end  
  puts conf_txt
elsif ARGV[0] == opt_sel[6]
  Dir.foreach(data_dir) do |item|
    next if item == '.' or item == '..'
      item_dir = conf_dir + item.gsub(/(.ip)/, '.conf')
      item_xml = item.gsub(/(.ip)/, '.xml')
      system(cmd + " -p" + mail_ports + include_file_cmd + item + " " + rate_cmd + " " + results_out + item_xml + " --echo > " + item_dir)
  end
  puts conf_txt
elsif ARGV[0] == opt_sel[7]
	Dir.foreach(data_dir) do |item|
		next if item == '.' or item == '..'
  		item_dir = conf_dir + item.gsub(/(.ip)/, '.conf')
  		item_xml = item.gsub(/(.ip)/, '.xml')
  		system(cmd + " -p" + remote_ports + "," + app_ports + "," + web_ports + "," + db_ports + "," + special_ports + "," + ms_ports + "," + mail_ports + include_file_cmd + item + " " + rate_cmd + " " + results_out + item_xml + " --echo > " + item_dir)
	end
	puts conf_txt
else puts opt_sel_err
end