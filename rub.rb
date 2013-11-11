#!/usr/bin/env ruby
require 'rake'
require 'date'
require './lib/directories'
require './lib/scanner'
require './lib/messages'
require './lib/options'

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
		Scanner.mass_apac
	elsif ARGV[0] == Options.opt_sel[1]
		Scanner.mass_eu
	elsif ARGV[0] == Options.opt_sel[2]
		Scanner.mass_us_east
	elsif ARGV[0] == Options.opt_sel[3]
		Scanner.mass_us_west
	elsif ARGV[0] == Options.opt_sel[4]
		Scanner.mass_south_america
	elsif ARGV[0] == Options.opt_sel[5]
		Scanner.mass_us_all
	elsif ARGV[0] == Options.opt_sel[6]
		Scanner.mass_all
	else puts Messages.opt_sel_err
	end
	puts Messages.scan_complete


elsif ARGV[1] == Options.scan_sel[1]
	puts Messages.tbd

=begin
# sudo nmap -p 22,80 -sS -P0 -n -O --osscan-limit --version-light --max-rate 1337 --randomize-hosts --open --reason -iL ./data/aws_gov.ip --excludefile ./conf/exclude.conf -oX andrew.xml
#	system(Scanner.nmapcmd + " -p " + Ports.remote_ports + Scanner.nmap_flags + a + Directories.exclude_file_cmd + " " + Directories.results_out+)

	if ARGV[0] == Options.opt_sel[0]
		Scanner.nmap_apac
	elsif ARGV[0] == Options.opt_sel[1]
		Scanner.nmap_eu
	elsif ARGV[0] == Options.opt_sel[2]
		Scanner.nmap_us_east
	elsif ARGV[0] == Options.opt_sel[3]
		Scanner.nmap_us_west
	elsif ARGV[0] == Options.opt_sel[4]
		Scanner.nmap_south_america
	elsif ARGV[0] == Options.opt_sel[5]
		Scanner.nmap_us_all
	elsif ARGV[0] == Options.opt_sel[6]
		Scanner.nmap_all
	else puts Messages.opt_sel_err
	end
	puts Messages.scan_complete


elsif ARGV[1] == Options.scan_sel[2]
	puts Messages.tbd

	if ARGV[0] == Options.opt_sel[0]
		Scanner.zmap_apac
	elsif ARGV[0] == Options.opt_sel[1]
		Scanner.zmap_eu
	elsif ARGV[0] == Options.opt_sel[2]
		Scanner.zmap_us_east
	elsif ARGV[0] == Options.opt_sel[3]
		Scanner.zmap_us_west
	elsif ARGV[0] == Options.opt_sel[4]
		Scanner.zmap_south_america
	elsif ARGV[0] == Options.opt_sel[5]
		Scanner.zmap_us_all
	elsif ARGV[0] == Options.opt_sel[6]
		Scanner.zmap_all
	else puts Messages.opt_sel_err
	end
	puts Messages.scan_complete

else puts Messages.rub_opt_sel_err
end