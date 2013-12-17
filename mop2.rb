#!/usr/bin/env ruby
#
# Used to calculate statistics
#
$LOAD_PATH << './lib'
require 'analysis'
require 'geoip'
require 'directories'
require 'fileutils'
require 'ox'

class Sample < ::Ox::Sax
  def attr(name, value)
	if "#{name}" == "addr"
		@@ip_class = "#{value},"
	elsif "#{name}" == "portid"
        @@portid_class = "#{value}\n"
	end
  end
  def text(value); puts "text #{value}"; end
end

handler = Sample.new()


scan_date_ary = []
commands = []
ARGV.each {|arg| commands << arg}
# 0=type, 1=date in D/M/YYYY, 2=report_type (banner or no banner) 
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
	f = File.open(rb_file)
	
	puts "[+] "+rb_file.gsub(/\.\/analysis\//, '')
	
	
	stats.write(Analysis.header+"\n")
	
	if rb_file =~ /masscan/
		
		csp = Analysis.csp_masscan_regex.match(rb_file.to_s)[1].to_s
		scanner_host = Analysis.scanner_name_regex.match(rb_file.to_s)[1].to_s
		Analysis.scanner_host scanner_host
		Ox.sax_parse(handler, f)
		i = 0
		until i == items.count
	
			target_geo = Analysis.ip_convert @@ip_class
			stats.write(Analysis.us_date+","+Analysis.thescannerip+","+csp+","+@@ip_class+@@portid_class+target_geo.latitude.to_s+","+
      					target_geo.longitude.to_s+","+target_geo.country_name.to_s+","+target_geo.continent_code.to_s+","+
      					target_geo.region_name.to_s+","+target_geo.city_name.to_s+"\n")
			
			i+=1
		end
		stats.close
	elsif rb_file =~ /zmap/
		reader = File.open(rb_file, 'r')
		firstline = reader.first
		port_only = /\"target_port\": (\d{1,5}),/.match(firstline)[1]
		scanner_host = /\"source_ip_first\": \"(\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b)\", \"/.match(firstline)[1]
		Analysis.scanner_host scanner_host
		i = 0
		reader.each do |line|
			zmap_ip = /\"saddr\": \"(.*)\"/.match(line)[1]
			stats.write(Analysis.us_date+","+Analysis.thescannerip+","+"andrew"+","+zmap_ip+","+port_only+","+target_geo.latitude.to_s+","+
      					target_geo.longitude.to_s+","+target_geo.country_name.to_s+","+target_geo.continent_code.to_s+","+
      					target_geo.region_name.to_s+","+target_geo.city_name.to_s+"\n")
		end
		stats.close
	elsif rb_file =~ /nmap/
		i = 0
=begin
		until i == items.count
			
			if items[i].at_xpath("hostnames") != nil
				namearea = items[i].at_xpath("hostnames")
				strip_name = namearea.xpath("hostname")
			end
			iparea = items[i].xpath("address")
			strip_ip = Analysis.ip_strip.match(iparea.to_s)[1].to_s
			puts strip_ip+","+strip_name.to_s
			i+=1
		end
=end
		stats.close
	else puts "error"
end
end