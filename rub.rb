#!/usr/bin/env ruby
require 'rake'
require 'date'

working_dir = "."
cmd = "/usr/local/sbin/masscan"
exclude_file = working_dir+"/conf/exclude.conf"
results_dir = working_dir+"/results/"
conf_dir = working_dir+"/conf/"
dir_date = Date.today.year.to_s+"/"+Date.today.month.to_s+"/"+Date.today.day.to_s+"/"
results_dir_date = results_dir + dir_date
confpath = conf_dir

opt_sel = ['apac','europe','north_america','south_america','all']
apac_reg = ['softlayer_apac.conf','aws_apac.conf','azure_apac.conf','dimension_data_apac.conf','huawei_apac.conf']
europe_reg = ['softlayer_eu_west.conf','aws_eu.conf','azure_europe_north.conf','azure_europe_west.conf','gogrid_europe_north.conf','joyent_eu.conf']
north_america_reg = ['softlayer_us_central.conf','softlayer_us_west.conf','softlayer_us_east.conf','aws_gov.conf','aws_us_east.conf','aws_us_west.conf','azure_us_central.conf','azure_us_east.conf','azure_us_west.conf','dimension_data_us_west.conf','gogrid_us_west.conf','hp.conf','joyent_us.conf','rackspace.conf','virtustream.conf']
south_america_reg = ['aws_south_america.conf','azure_south_america.conf']
all_reg = apac_reg+europe_reg+north_america_reg+south_america_reg
opt_sel_err = "[-] Usage: ./rub.rb <region>"

commands = []
ARGV.each {|arg| commands << arg}
 
## Create directory for current day (if it doesn't already exist)
if File.directory?(dir_date)
	puts "[+] The directory" + results_dir_date + " already exists, no need to create it."
else
	FileUtils.mkdir_p results_dir_date
	puts "[+] Created " + results_dir_date
end
## Run scan
puts "[+] Beginning scan..."
if ARGV[0] == opt_sel[0]
	apac_reg.shuffle.each do |a|
		system(cmd + " -c " + confpath + a + " --banners --excludefile " + exclude_file)
	end
elsif ARGV[0] == opt_sel[1]
	europe_reg.shuffle.each do |e|
		system(cmd + " -c " + confpath + e + " --banners --excludefile " + exclude_file)
	end
elsif ARGV[0] == opt_sel[2]
	north_america_reg.shuffle.each do |i|
		system(cmd + " -c " + confpath + i + " --banners --excludefile " + exclude_file)
	end
elsif ARGV[0] == opt_sel[3]
	south_america_reg.shuffle.each do |o|
		system(cmd + " -c " + confpath + o + " --banners --excludefile " + exclude_file)
	end
elsif ARGV[0] == opt_sel[4]
	all_reg.shuffle.each do |u|
		system(cmd + " -c " + confpath + u + " --banners --excludefile " + exclude_file)
	end
else puts opt_sel_err
end
puts "[+] Scan complete."
