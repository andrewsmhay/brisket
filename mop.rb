#!/usr/bin/env ruby
#
# Used to calculate statistics
#
$LOAD_PATH << './lib'
require 'nokogiri'
require 'analysis'
require 'geoip'
require 'directories'
require 'fileutils'
require 'ox'

=begin
class Sample < ::Ox::Sax
  def attr(name, value)
	if "#{name}" == "addr"
		print "#{value},"
	elsif "#{name}" == "portid"
        print "#{value}\n"
	end
  end
  def text(value); puts "text #{value}"; end
end

handler = Sample.new()
Ox.sax_parse(handler, rb_file)
=end

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
	
	doc = Nokogiri::XML(f)
	root = doc.root
	puts "[+] "+rb_file.gsub(/\.\/analysis\//, '')
	f.close
	stats.write(Analysis.header+"\n")
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
			strip_ip = Analysis.ip_strip.match(iparea.to_s)[1].to_s
			target_geo = Analysis.ip_convert strip_ip
			
			stats.write(Analysis.us_date+","+Analysis.thescannerip+","+csp+","+strip_ip+","+port_only+","+target_geo.latitude.to_s+","+
      					target_geo.longitude.to_s+","+target_geo.country_name.to_s+","+target_geo.continent_code.to_s+","+
      					target_geo.region_name.to_s+","+target_geo.city_name.to_s+"\n")
			
			i+=1
		end
		stats.close
	elsif rb_file =~ /zmap/
		reader = File.read(rb_file)
		port_only = /"target_port": (\d{1,5}),/.match(reader)[1]
		stats.close
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
			strip_ip = Analysis.ip_strip.match(iparea.to_s)[1].to_s
			puts strip_ip+","+strip_name.to_s
			i+=1
		end
		stats.close
	else puts "error"
end
end