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

class MyParser < ::Ox::Sax
  attr_accessor :addressList

  def initialize()
    @currStack = []
    @addressList = []
  end

  def start_element(elem)
    @currStack << elem
    if (elem.to_s == "host")
      #@addressList << { :address => nil, :protocol => nil, :port => nil }
      @addressList << { :address => nil, :port => nil }
    end
  end

  def end_element(elem)
    @currStack.first(@currStack.size - 1)
  end

  def most_recent_host
    if (@addressList.size > 0)
      @addressList[@addressList.size - 1]
    else
      nil
    end
  end

  def top
    if (@currStack.size > 0)
      @currStack[@currStack.size - 1].to_s
    else
      nil
    end
  end
  
  def attr(name, value)
    if top != nil
      if (top == 'address') && (name.to_s == 'addr')
        most_recent_host['address'] = value.to_s
      #elsif (top == 'port') && (name.to_s == 'protocol')
      #  most_recent_host['protocol'] = value.to_s
      elsif (top == 'port') && (name.to_s == 'portid')
        most_recent_host['port'] = value.to_s
      end
    end
  end

  def text(value)
    if (top != nil) && (top != 'banner')
    end
  end
end

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

	#f = File.open(rb_file)
	
	if rb_file =~ /masscan/
		
		handler = MyParser.new()
		csp = Analysis.csp_masscan_regex.match(rb_file.to_s)[1].to_s
		scanner_host = Analysis.scanner_name_regex.match(rb_file.to_s)[1].to_s
		Analysis.scanner_host scanner_host
		IO.foreach(rb_file) do |x|
			x+5
			Ox.sax_parse(handler,x)
			handler.addressList.each do |addr|
	  			target_geo = Analysis.ip_convert "#{addr['address']}"
				stats.write(Analysis.us_date+","+Analysis.thescannerip+","+csp+","+"#{addr['address']},#{addr['port']},"+target_geo.latitude.to_s+","+
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