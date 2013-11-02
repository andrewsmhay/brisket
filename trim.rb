#!/usr/bin/env ruby

require 'rake'
require 'date'
require 'open-uri'
require 'zlib'

working_dir = "."
remote_ports = 	"22,23,3389"
app_ports = 	"21,139,445"
web_ports =		"80,443,8080"
db_ports =		"1434,1521,3306,5432"
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
opt_sel = ['remote', 'apps', 'web', 'db', 'all']
opt_sel_err = "[-] Usage: ./trim.rb <remote|apps|web|db|all>"
geo_dat_city = "http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz"
geo_dat_country = "http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz"
conf_txt = "[+] Configuration files successfully generated."

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
  		system(cmd + " -p" + remote_ports + "," + app_ports + "," + web_ports + "," + db_ports + include_file_cmd + item + " " + rate_cmd + " " + results_out + item_xml + " --echo > " + item_dir)
	end
	puts conf_txt
else puts opt_sel_err
end

open('GeoLiteCity.dat.gz', 'w') do |local_file|
  open(geo_dat_city) do |remote_file|
    local_file.write(Zlib::GzipReader.new(remote_file).read)
  end
end
puts "[+] GeoLiteCity database downloaded..."
open('GeoIP.dat.gz', 'w') do |local_file|
  open(geo_dat_country) do |remote_file|
    local_file.write(Zlib::GzipReader.new(remote_file).read)
  end
end
puts "[+] GeoIP database downloaded..."
File.rename("GeoLiteCity.dat.gz", "GeoLiteCity.dat")
File.rename("GeoIP.dat.gz", "GeoIP.dat") 
