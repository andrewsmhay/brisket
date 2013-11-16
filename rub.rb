#!/usr/bin/env ruby
$LOAD_PATH << '/home/scanner/brisket/lib'
require 'rake'
require 'date'
require 'directories'
require 'scanner'
require 'messages'
require 'options'
require 'ports'
require 'naming'

commands = []
ARGV.each {|arg| commands << arg}
 
## Create directory for current day (if it doesn't already exist)
if File.directory?(Directories.results_dir_date)
	puts "[+] The directory" + Directories.results_dir_date + " already exists, no need to create it."
	f = File.open('/var/log/brisket.log', 'a+')
	f.puts Messages.syslog_stamp+"[+] The directory" + Directories.results_dir_date + " already exists, no need to create it."
	f.close
else
	FileUtils.mkdir_p Directories.results_dir_date
	puts Messages.create_dir
	f = File.open('/var/log/brisket.log', 'a+')
	f.puts Messages.syslog_stamp+"[+] Created " + Directories.results_dir_date
	f.close
end
## Run scan
puts Messages.scanstart
f = File.open('/var/log/brisket.log', 'a+')
f.puts Messages.syslog_stamp+Messages.scanstart
f.close

if ARGV[1] == Options.scan_sel[0]
	if ARGV[0] == Options.opt_sel[0]
		Scanner.mass Options.apac_reg
	elsif ARGV[0] == Options.opt_sel[1]
		Scanner.mass Options.europe_reg
	elsif ARGV[0] == Options.opt_sel[2]
		Scanner.mass Options.north_america_reg_east
	elsif ARGV[0] == Options.opt_sel[3]
		Scanner.mass Options.north_america_reg_west
	elsif ARGV[0] == Options.opt_sel[4]
		Scanner.mass Options.south_america_reg
	elsif ARGV[0] == Options.opt_sel[5]
		Scanner.mass Options.north_america_reg
	elsif ARGV[0] == Options.opt_sel[6]
		Scanner.mass Options.all_reg
	elsif ARGV[0] == Options.opt_sel[7]
		Scanner.mass Options.gov_reg		
	else puts Messages.opt_sel_err
	end
puts Messages.scan_complete
f = File.open('/var/log/brisket.log', 'a+')
f.puts Messages.syslog_stamp+Messages.scan_complete
f.puts Messages.syslog_stamp+"[+] Results file written to " + Directories.results_dir_date + 
f.close

elsif ARGV[1] == Options.scan_sel[1]
	if ARGV[0] == Options.opt_sel[0]
		Scanner.nmap Options.apac_ip
	elsif ARGV[0] == Options.opt_sel[1]
		Scanner.nmap Options.europe_ip
	elsif ARGV[0] == Options.opt_sel[2]
		Scanner.nmap Options.na_east_ip
	elsif ARGV[0] == Options.opt_sel[3]
		Scanner.nmap Options.na_west_ip
	elsif ARGV[0] == Options.opt_sel[4]
		Scanner.nmap Options.sa_ip
	elsif ARGV[0] == Options.opt_sel[5]
		Scanner.nmap Options.na_all_ip
	elsif ARGV[0] == Options.opt_sel[6]
		Scanner.nmap Options.all_ip
	elsif ARGV[0] == Options.opt_sel[7]
		Scanner.nmap Options.reg_ip
	else puts Messages.opt_sel_err
	end
puts Messages.scan_complete
f = File.open('/var/log/brisket.log', 'a+')
f.puts Messages.scan_complete
f.close

elsif ARGV[1] == Options.scan_sel[2]
	if ARGV[0] == Options.opt_sel[0]
		Scanner.zmap Options.apac_ip
	elsif ARGV[0] == Options.opt_sel[1]
		Scanner.zmap Options.europe_ip
	elsif ARGV[0] == Options.opt_sel[2]
		Scanner.zmap Options.na_east_ip
	elsif ARGV[0] == Options.opt_sel[3]
		Scanner.zmap Options.na_west_ip
	elsif ARGV[0] == Options.opt_sel[4]
		Scanner.zmap Options.sa_ip
	elsif ARGV[0] == Options.opt_sel[5]
		Scanner.zmap Options.na_all_ip
	elsif ARGV[0] == Options.opt_sel[6]
		Scanner.zmap Options.all_ip
	elsif ARGV[0] == Options.opt_sel[7]
		Scanner.zmap Options.gov_ip
	else puts Messages.opt_sel_err
	end
puts Messages.scan_complete
f = File.open('/var/log/brisket.log', 'a+')
f.puts Messages.syslog_stamp+Messages.scan_complete
f.close
else puts Messages.rub_opt_sel_err
end