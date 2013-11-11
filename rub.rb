#!/usr/bin/env ruby
require 'rake'
require 'date'
require './lib/directories'
require './lib/scanner'
require './lib/messages'
require './lib/options'

=begin
opt_sel = ['apac','europe','us_east','us_west','us_all','south_america','all']
apac_reg = ['masscan_softlayer_apac.conf','masscan_aws_apac.conf','masscan_azure_apac.conf','masscan_dimension_data_apac.conf','masscan_huawei_apac.conf']
europe_reg = ['masscan_tier3_eu_west.conf','masscan_softlayer_eu_west.conf','masscan_aws_eu.conf','masscan_azure_europe_north.conf',
			  'masscan_azure_europe_west.conf','masscan_gogrid_europe_north.conf','masscan_joyent_eu.conf']
north_america_reg_east = ['masscan_tier3_us_central.conf','masscan_tier3_us_east.conf','masscan_softlayer_us_central.conf','masscan_softlayer_us_east.conf','masscan_aws_us_east.conf',
						  'masscan_azure_us_central.conf','masscan_azure_us_east.conf','masscan_virtustream_us_east.conf']
north_america_reg_west = ['masscan_tier3_us_west.conf','masscan_softlayer_us_west.conf','masscan_aws_gov_us_west.conf','masscan_aws_us_west.conf','masscan_azure_us_west.conf',
						  'masscan_dimension_data_us_west.conf','masscan_gogrid_us_west.conf','masscan_hp_us_west.conf','masscan_rackspace.conf','masscan_joyent_us_west.conf']
north_america_reg = north_america_reg_east+north_america_reg_west
south_america_reg = ['masscan_aws_south_america.conf']
all_reg = apac_reg+europe_reg+north_america_reg+south_america_reg
f_ext = ['.conf','.ip','.xml','.json']
scan_sel = ['masscan','nmap','zmap']
=end

commands = []
ARGV.each {|arg| commands << arg}
 
## Create directory for current day (if it doesn't already exist)
if File.directory?(Directories.dir_date)
	puts "[+] The directory" + Directories.results_dir_date + " already exists, no need to create it."
else
	FileUtils.mkdir_p Directories.results_dir_date
	puts "[+] Created " + Directories.results_dir_date
end
## Run scan
puts Messages.scanstart
if ARGV[1] == Options.scan_sel[0]
	if ARGV[0] == Options.opt_sel[0]
		Options.apac_reg.shuffle.each { |a| system(Scanner.masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
	elsif ARGV[0] == Options.opt_sel[1]
		Options.europe_reg.shuffle.each { |a| system(Scanner.masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
		#Options.europe_reg.shuffle.each do |a|
		#	system(Scanner.masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)
		#end
	elsif ARGV[0] == Options.opt_sel[2]
		Options.north_america_reg_east.shuffle.each { |a| system(Scanner.masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
		#Options.north_america_reg_east.shuffle.each do |a|
		#	system(Scanner.masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)
		#end
	elsif ARGV[0] == Options.opt_sel[3]
		Options.north_america_reg_west.shuffle.each { |a| system(Scanner.masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
		#Options.north_america_reg_west.shuffle.each do |a|
		#	system(Scanner.masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)
		#end
	elsif ARGV[0] == Options.opt_sel[4]
		Options.north_america_reg.shuffle.each { |a| system(Scanner.masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
		#Options.north_america_reg.shuffle.each do |a|
		#	system(Scanner.masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)
		#end
	elsif ARGV[0] == Options.opt_sel[5]
		Options.south_america_reg.shuffle.each { |a| system(Scanner.masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
		#Options.south_america_reg.shuffle.each do |a|
		#	system(Scanner.masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)
		#end
	elsif ARGV[0] == Options.opt_sel[6]
		Options.all_reg.shuffle.each { |a| system(Scanner.masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
		#Options.all_reg.shuffle.each do |a|
		#	system(Scanner.masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)
		#end
		
	else puts Messages.opt_sel_err
	end
	puts Messages.scan_complete

# sudo nmap -p 22,80 -sS -P0 -n -O --osscan-limit --version-light --max-rate 1337 --randomize-hosts --open --reason -iL ./data/aws_gov.ip --excludefile ./conf/exclude.conf -oX andrew.xml
elsif ARGV[1] == Options.scan_sel[1]
	puts Messages.tbd

=begin
	if ARGV[0] == opt_sel[0]
		apac_reg.shuffle.each do |a| #<- this isn't right...need data_dir IP file
		#	system(Scanner.nmapcmd + " -p " + Ports.remote_ports + Scanner.nmap_flags + a + Directories.exclude_file_cmd + " " + Directories.results_out+)
		end
	elsif ARGV[0] == opt_sel[1]
		europe_reg.shuffle.each do |a|
			system(
		end
	elsif ARGV[0] == opt_sel[2]
		north_america_reg_east.shuffle.each do |a|
			system(
		end
	elsif ARGV[0] == opt_sel[3]
		north_america_reg_west.shuffle.each do |a|
			system(
		end
	elsif ARGV[0] == opt_sel[4]
		north_america_reg.shuffle.each do |a|
			system(
		end
	elsif ARGV[0] == opt_sel[5]
		south_america_reg.shuffle.each do |a|
			system(
		end
	elsif ARGV[0] == opt_sel[6]
		all_reg.shuffle.each do |a|
			system(
		end
	else puts Messages.opt_sel_err
	end
=end
elsif ARGV[1] == Options.scan_sel[2]
	puts Messages.tbd

else puts Messages.rub_opt_sel_err
end