#!/usr/bin/env ruby
#
# Remove closed ports
#
$LOAD_PATH << '/home/scanner/brisket/lib'
require 'analysis'
require 'geoip'
require 'directories'
require 'fileutils'

commands = []
ARGV.each {|arg| commands << arg}
# [0]=type, [1]=date in D/M/YYYY
# ./smoke_ring.rb masscan 3/12/2013

Analysis.dateinput ARGV[1]

rb_file_location = "./analysis/"+Analysis.scan_date+"/"
path = "tmp"
tmp_file_location = rb_file_location+path
FileUtils.mkdir_p tmp_file_location
rb_file_master = Dir.glob(rb_file_location+"*"+ARGV[0]+"*")

rb_file_master.each do |rb_file|
	filename = rb_file.to_s.gsub("./analysis/"+Analysis.scan_date, '')
	new_file = File.open(rb_file_location+"tmp"+filename, "a")

	puts "[+] "+rb_file.gsub(/\.\/analysis\//, '')

	IO.foreach(rb_file) do |x|
		if x =~ /closed/
		else new_file.write(x)
		end
	end
	new_file.close
	FileUtils.mv(rb_file_location+"tmp"+filename, rb_file_location)
end
FileUtils.rm_rf(rb_file_location+"tmp")