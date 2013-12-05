#!/usr/bin/env ruby
#
# Used to calculate statistics
#
$LOAD_PATH << './lib'
require 'nokogiri'
require 'awesome_print'
require 'analysis'
require 'geoip'

commands = []
ARGV.each {|arg| commands << arg}
# 0=type, 1=date, 2=report_type (banner or no banner) 
if ARGV[1].to_s =~ /\-/
	puts "dash"
elsif ARGV[1].to_s =~ /\//
	puts "slash"
end	

rb_file_master = Dir.glob("./analysis/"+ARGV[1]+"/*"+ARGV[0]+"*")
rb_file_master.each do |rb_file|
	f = File.open(rb_file)
	doc = Nokogiri::XML(f)
	root = doc.root
	puts "[+] "+rb_file.gsub(/\.\/analysis\//, '')
	puts Analysis.header
	if rb_file =~ /masscan/
		rule_name = root["nmaprun"]
		items = root.xpath("host")
		i = 0
		until i == items.count
			iparea = items[i].xpath("address")
			portarea = items[i].at_xpath("ports")
			strip_port = Analysis.strip_port_regex.match(portarea.to_s)
			port_only = Analysis.port_only_regex.match(strip_port.to_s).to_s
			strip_ip = iparea.to_s.gsub(/\<address addr\=\"/, '').gsub(/\"\saddrtype\=\"ipv4\"\/\>/, '')
			target_geo = Analysis.ip_convert strip_ip
			
			Analysis.results(strip_ip, port_only, target_geo)
			i+=1
		end
	elsif rb_file =~ /zmap/
		reader = File.read(rb_file)
		p = /"target_port": (\d{1,5}),/.match(reader)[1]
		
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
f.close
end