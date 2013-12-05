#!/usr/bin/env ruby
#
# Used to calculate statistics
#
$LOAD_PATH << './lib'
require 'nokogiri'
require 'awesome_print'
require 'analysis'
require 'geoip'
require 'directories'

scan_date_ary = []
commands = []
ARGV.each {|arg| commands << arg}
# 0=type, 1=date in D/M/YYYY, 2=report_type (banner or no banner) 
# ./mop.rb masscan 3/12/2013
#

Analysis.dateinput ARGV[1]

rb_file_master = Dir.glob("./analysis/"+Analysis.scan_date+"/*"+ARGV[0]+"*")

if File.directory?(Directories.stats+"/"+Analysis.scan_date)
	puts "[+] Directory already exists, not need to create..."
else
	FileUtils.mkdir_p Directories.stats+"/"+Analysis.scan_date
	puts "[+] Created "+Directories.stats+"/"+Analysis.scan_date
end

rb_file_master.each do |rb_file|
	filename = rb_file.to_s.gsub("./analysis/"+Analysis.scan_date, '')
	csvname = filename.gsub(/.xml/ , '.csv')
	stats = File.open(Directories.stats+csvname, "a")
	f = File.open(rb_file)
	doc = Nokogiri::XML(f)
	root = doc.root
	puts "[+] "+rb_file.gsub(/\.\/analysis\//, '')
	stats.write(Analysis.header)
	if rb_file =~ /masscan/
		rule_name = root["nmaprun"]
		items = root.xpath("host")
		
		csp = Analysis.csp_masscan_regex.match(rb_file.to_s)[1].to_s
		scanner_host = Analysis.scanner_name_regex.match(rb_file.to_s)[1].to_s
		Analysis.scanner_host scanner_host

		i = 0
		until i == items.count
			iparea = items[i].xpath("address")
			portarea = items[i].at_xpath("ports")
			strip_port = Analysis.strip_port_regex.match(portarea.to_s)
			port_only = Analysis.port_only_regex.match(strip_port.to_s).to_s
			strip_ip = iparea.to_s.gsub(/\<address addr\=\"/, '').gsub(/\"\saddrtype\=\"ipv4\"\/\>/, '')
			target_geo = Analysis.ip_convert strip_ip
			
			stats.write(Analysis.us_date+","+Analysis.thescannerip+","+csp+","+strip_ip+","+port_only+","+target_geo.latitude.to_s+","+
      					target_geo.longitude.to_s+","+target_geo.country_name.to_s+","+target_geo.continent_code.to_s+","+
      					target_geo.region_name.to_s+","+target_geo.city_name.to_s+"\n")
			#Analysis.results(Analysis.thescannerip, strip_ip, csp, port_only, target_geo, Analysis.us_date)
			i+=1
		end
	elsif rb_file =~ /zmap/
		reader = File.read(rb_file)
		port_only = /"target_port": (\d{1,5}),/.match(reader)[1]
		
	elsif rb_file =~ /nmap/
		rule_name = root["nmaprun"]
		items = root.xpath("host")
		i = 0
		until i == items.count
			if items[i].at_xpath("hostnames") != nil
				namearea = items[i].at_xpath("hostnames")
				strip_name = namearea.xpath("hostname")
			end
			iparea = items[i].xpath("address")
			strip_ip = iparea.to_s.gsub(/\<address addr\=\"/, '').gsub(/\"\saddrtype\=\"ipv4\"\/\>/, '')
			puts strip_ip+","+strip_name.to_s
			i+=1
		end
	else puts "error"
end
stats.close
f.close
end