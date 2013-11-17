#!/usr/bin/env ruby
$LOAD_PATH << '/home/scanner/brisket/lib'
require 'nokogiri'
require 'geoip'
require 'date'
require 'options'
require 'directories'
require 'messages'

dir_date = ARGV[1]
#item_dir= []
commands = []
inputter = []
ARGV.each {|arg| commands << arg}

puts "[+] Beginning conversion..."
if ARGV[0] == Options.opt_sel_region[0] #apac
  Dir.glob(Directories.crutch_results_dir_date+"*"+Options.opt_sel_region[0]+"*.xml") do |rb_file|
    xml = Nokogiri::XML.parse(open rb_file)
      xml.css('nmaprun host').each do |host|
        begin
          target_address = host.css('address').first['addr']
          target_geo = GeoIP.new('GeoLiteCity.dat').city(target_address)
          target_ports = host.css('port').first['portid']
          if host.css('banner').empty?
            target_banner = 'NULL'
          else
            target_banner = host.css('banner')
          end
          inputter << target_address.to_s + "|" + target_ports.to_s + "|" + target_geo.latitude.to_s+"|"+target_geo.longitude.to_s + "|" + target_banner.to_s.gsub(/<\/*banner>/, '')
        rescue Exception => e
          puts "[-] Error On: #{target_address}"
          next
        end
      end
  end
  f = File.open(rb_file+".csv", "w")
  f.write(inputter)
  #f.each do |g|
  #  g.write(inputter)
  #end
  f.close
elsif ARGV[0] == Options.opt_sel_region[1] #europe
  Dir.glob(Directories.crutch_results_dir_date+"*"+Options.opt_sel_region[1]+"*.xml") do |rb_file|
    xml = Nokogiri::XML.parse(open rb_file)
      xml.css('nmaprun host').each do |host|
        begin
          target_address = host.css('address').first['addr']
          target_geo = GeoIP.new('GeoLiteCity.dat').city(target_address)
          target_ports = host.css('port').first['portid']
          if host.css('banner').empty?
            target_banner = 'NULL'
          else
            target_banner = host.css('banner')
          end
          inputter << target_address.to_s + "|" + target_ports.to_s + "|" + target_geo.latitude.to_s+"|"+target_geo.longitude.to_s + "|" + target_banner.to_s.gsub(/<\/*banner>/, '')
        rescue Exception => e
          puts "[-] Error On: #{target_address}"
          next
        end
      end
    f = File.open(rb_file+".csv", "w")
    f.write(inputter)
    f.close
  end
elsif ARGV[0] == Options.opt_sel_region[2] #us_east
  Dir.glob(Directories.crutch_results_dir_date+"*"+Options.opt_sel_region[2]+"*.xml") do |rb_file|
    xml = Nokogiri::XML.parse(open rb_file)
      xml.css('nmaprun host').each do |host|
        begin
          target_address = host.css('address').first['addr']
          target_geo = GeoIP.new('GeoLiteCity.dat').city(target_address)
          target_ports = host.css('port').first['portid']
          if host.css('banner').empty?
            target_banner = 'NULL'
          else
            target_banner = host.css('banner')
          end
          inputter << target_address.to_s + "|" + target_ports.to_s + "|" + target_geo.latitude.to_s+"|"+target_geo.longitude.to_s + "|" + target_banner.to_s.gsub(/<\/*banner>/, '')
        rescue Exception => e
          puts "[-] Error On: #{target_address}"
          next
        end
      end
    f = File.open(rb_file+".csv", "w")
    f.write(inputter)
    f.close
  end
elsif ARGV[0] == Options.opt_sel_region[3] #us_west
  Dir.glob(Directories.crutch_results_dir_date+"*"+Options.opt_sel_region[3]+"*.xml") do |rb_file|
    xml = Nokogiri::XML.parse(open rb_file)
      xml.css('nmaprun host').each do |host|
        begin
          target_address = host.css('address').first['addr']
          target_geo = GeoIP.new('GeoLiteCity.dat').city(target_address)
          target_ports = host.css('port').first['portid']
          if host.css('banner').empty?
            target_banner = 'NULL'
          else
            target_banner = host.css('banner')
          end
          inputter << target_address.to_s + "|" + target_ports.to_s + "|" + target_geo.latitude.to_s+"|"+target_geo.longitude.to_s + "|" + target_banner.to_s.gsub(/<\/*banner>/, '')
        rescue Exception => e
          puts "[-] Error On: #{target_address}"
          next
        end
      end
    f = File.open(rb_file+".csv", "w")
    f.write(inputter)
    f.close
  end
elsif ARGV[0] == Options.opt_sel_region[4] #south_america
  Dir.glob(Directories.crutch_results_dir_date+"*"+Options.opt_sel_region[4]+"*.xml") do |rb_file|
    xml = Nokogiri::XML.parse(open rb_file)
      xml.css('nmaprun host').each do |host|
        begin
          target_address = host.css('address').first['addr']
          target_geo = GeoIP.new('GeoLiteCity.dat').city(target_address)
          target_ports = host.css('port').first['portid']
          if host.css('banner').empty?
            target_banner = 'NULL'
          else
            target_banner = host.css('banner')
          end
          inputter << target_address.to_s + "|" + target_ports.to_s + "|" + target_geo.latitude.to_s+"|"+target_geo.longitude.to_s + "|" + target_banner.to_s.gsub(/<\/*banner>/, '')
        rescue Exception => e
          puts "[-] Error On: #{target_address}"
          next
        end
      end
    f = File.open(rb_file+".csv", "w")
    f.write(inputter)
    f.close
  end
elsif ARGV[0] == Options.opt_sel_region[5] #all
  Dir.glob(Directories.crutch_results_dir_date+"*.xml") do |rb_file|
    xml = Nokogiri::XML.parse(open rb_file)
      xml.css('nmaprun host').each do |host|
        begin
          target_address = host.css('address').first['addr']
          target_geo = GeoIP.new('GeoLiteCity.dat').city(target_address)
          target_ports = host.css('port').first['portid']
          if host.css('banner').empty?
            target_banner = 'NULL'
          else
            target_banner = host.css('banner')
          end
          inputter << target_address.to_s + "|" + target_ports.to_s + "|" + target_geo.latitude.to_s+"|"+target_geo.longitude.to_s + "|" + target_banner.to_s.gsub(/<\/*banner>/, '')
        rescue Exception => e
          puts "[-] Error On: #{target_address}"
          next
        end
      end
    f = File.open(rb_file+".csv", "w")
    f.write(inputter)
    f.close
  end
else puts Messages.crutch_opt_sel_err
end
puts Messages.converted