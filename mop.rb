#!/usr/bin/env ruby
#
# Used to calculate statistics
#
$LOAD_PATH << '/home/scanner/brisket/lib'
require 'analysis'
require 'geoip'
require 'directories'
require 'fileutils'

scan_date_ary = []
commands = []
ARGV.each {|arg| commands << arg}
# [0]=type, [1]=date in D/M/YYYY
# ./mop.rb masscan 3/12/2013

Analysis.dateinput ARGV[1]

rb_file_master = Dir.glob("./analysis/"+Analysis.scan_date+"/*"+ARGV[0]+"*")

if File.directory?(Directories.stats+"/"+Analysis.scan_date)
	puts "[+] Directory already exists, no need to create..."
else
	FileUtils.mkdir_p Directories.stats+"/"+Analysis.scan_date
	puts "[+] Created "+Directories.stats+"/"+Analysis.scan_date
end

rb_file_master.each do |rb_file|
	filename = rb_file.to_s.gsub("./analysis/"+Analysis.scan_date, '')
	csvname = filename.gsub(/.xml/ , '.csv')
	stats = File.open(Directories.stats+"/"+Analysis.scan_date+"/"+csvname, "a")
	
	stats.write(Analysis.header+"\n")

	puts "[+] "+rb_file.gsub(/\.\/analysis\//, '')
	
	if rb_file =~ /masscan/
	
		csp = Analysis.csp_masscan_regex.match(rb_file.to_s)[1].to_s
		scanner_host = Analysis.scanner_name_regex.match(rb_file.to_s)[1].to_s
		Analysis.scanner_host scanner_host
		IO.foreach(rb_file) do |x|
			if x.to_s =~ /host endtime/
				ipx = Analysis.ip_strip.match(x)[1]
				portx = Analysis.strip_port_regex.match(x)[1]
		  			target_geo = Analysis.ip_convert ipx
					stats.write(Analysis.us_date+","+Analysis.thescannerip+","+csp+","+ipx+","+portx+","+target_geo.latitude.to_s+","+	
		      					target_geo.longitude.to_s+","+target_geo.country_name.to_s+","+target_geo.continent_code.to_s+","+
		      					target_geo.region_name.to_s+","+target_geo.city_name.to_s+"\n")
			end
		end
		stats.close
	elsif rb_file =~ /zmap/

		csp = Analysis.csp_zmap_regex.match(rb_file.to_s)[1].to_s
		firstline = f.first
		port_only = /\"target_port\": (\d{1,5}),/.match(firstline)[1]
		scanner_host = /\"source_ip_first\": \"(\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b)\", \"/.match(firstline)[1]
		Analysis.scanner_host scanner_host
		i = 0
		f.each do |line|
			zmap_ip = /\"saddr\": \"(.*)\"/.match(line)[1]
			target_geo = Analysis.ip_convert zmap_ip
			stats.write(Analysis.us_date+","+Analysis.thescannerip+","+csp+","+zmap_ip+","+port_only+","+target_geo.latitude.to_s+","+
      					target_geo.longitude.to_s+","+target_geo.country_name.to_s+","+target_geo.continent_code.to_s+","+
      					target_geo.region_name.to_s+","+target_geo.city_name.to_s+"\n")
		end
		stats.close
	elsif rb_file =~ /nmap/
		i = 0

		stats.close
	else puts "error"
end
end