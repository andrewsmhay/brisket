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
rb_tmp_path = FileUtils.mkdir_p(tmp_file_location) unless File.exists?(tmp_file_location)
rb_file_master = Dir.glob(rb_file_location+"*"+ARGV[0]+"*")

rb_file_master.each do |rb_file|
	
	new_file = File.open(Directories.stats+"/"+Analysis.scan_date+"/tmp/"+rb_file, "a")

	puts "[+] "+rb_file.gsub(/\.\/analysis\//, '')

	IO.foreach(rb_file) do |x|
		if x =~ /open/
			new_file.write(x)
		end
	end
	new_file.close
end