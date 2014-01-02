#!/usr/bin/env ruby
$LOAD_PATH << '/home/scanner/brisket/lib'
require 'date'
require 'tor'

require 'directories'
require 'analysis'

commands = []
ARGV.each {|arg| commands << arg}

rb_file_location = "./analysis/"+Analysis.scan_date+"/"
path = "tmp"
tmp_file_location = rb_file_location+path
FileUtils.mkdir_p tmp_file_location
rb_file_master = Dir.glob(rb_file_location+"*"+ARGV[0]+"*")

rb_file_master.each do |rb_file|
	filename = rb_file.to_s.gsub("./analysis/"+Analysis.scan_date, '')
	filename2 = "title_"+filename.gsub("/", '')
	filename3 = "banner_"+filename.gsub("/", '')
	new_file = File.open(rb_file_location+"tmp"+filename, "a")

=begin

Initialize tor proxy
Validate that the IP address assigned via tor is not the gateway IP address of the non-tor gateway

ARGV0 = type of scanner (masscan, zmap, nmap)
ARGV1 = date to scan for
ARGV2 = ignore IP addresses with banner info already in db? --ignore or -i


Read in csv results file from ~/brisket/stats/
IF port is 80 or 443
	curl the webserver IP address via tor proxy
	store header results in postgres table
ELSE
	nc the IP address via tor proxy
	store header results in postgres table
END


=end