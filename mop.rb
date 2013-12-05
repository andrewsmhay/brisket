#!/usr/bin/env ruby
#
# Used to calculate statistics
#
$LOAD_PATH << './lib'
require 'nokogiri'
require 'awesome_print'
require 'analysis'

commands = []
ARGV.each {|arg| commands << arg}
# 1 type, 2 date
puts ARGV[0]
puts ARGV[1]
rb_file_master = Dir.glob("./analysis/"+ARGV[1]+"/*"+ARGV[0]+"*")
rb_file_master.each do |rb_file|
	f = File.open(rb_file)
	doc = Nokogiri::XML(f)
	root = doc.root
	puts "[+] "+rb_file.gsub(/\.\/analysis\//, '')
	if rb_file =~ /masscan/
		rule_name = Analysis.nmap_rule_name
		items = root.xpath("host")
		i = 0
		until i == items.count
			iparea = items[i].xpath("address")
			portarea = items[i].at_xpath("ports")
			strip_port = /portid\=\"(.+)\"/.match(portarea.to_s)
			port_only = /(\d{1,5})/.match(strip_port.to_s).to_s
			strip_ip = iparea.Analysis.stripip
			puts strip_ip+","+port_only
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
			strip_ip = iparea.Analysis.stripip
			puts strip_ip+","+strip_name.to_s
			i+=1
		end
	else puts "error"
end
f.close
end