#!/usr/bin/env ruby
require 'nokogiri'
require 'geoip'

opt_sel_err = "[-] Usage: ./turn.rb <apac|europe|us_east|us_west|south_america|all>"
working_dir = "/home/scanner/brisket"
results_dir = working_dir+"/results/"
dir_date = Date.today.year.to_s+"/"+Date.today.month.to_s+"/"+Date.today.day.to_s+"/"
results_dir_date = results_dir + dir_date
item_dir= []
opt_sel_region = ['apac','europe','us_east','us_west','south_america','all']
commands = []
inputter = []
timenow = Time.new
ARGV.each {|arg| commands << arg}

#.count.uniq
puts "[+] Generating Statistics..."
if ARGV[0] == opt_sel_region[0] #apac
  Dir.glob(results_dir_date+"/*"+opt_sel_region[0]+"*.xml") do |rb_file|
    xml = Nokogiri::XML.parse(open rb_file)
      xml.css('nmaprun host').each do |host|
        begin
          target_address = host.css('address').first['addr']
          target_ports = host.css('port').first['portid']
          if host.css('banner').empty?
            target_banner = 'NULL'
          else
            target_banner = host.css('banner')
          end
          inputter << target_address.to_s + "|" + target_ports.to_s + target_banner.to_s.gsub(/<\/*banner>/, '')
        rescue Exception => e
          puts "[-] Error On: #{target_address}"
          next
        end
      end
  end
elsif ARGV[0] == opt_sel_region[1] #europe
  Dir.glob(results_dir_date+"/*"+opt_sel_region[1]+"*.xml") do |rb_file|
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
          inputter << target_address.to_s + "|" + target_ports.to_s + target_banner.to_s.gsub(/<\/*banner>/, '')
        rescue Exception => e
          puts "[-] Error On: #{target_address}"
          next
        end
      end
  end
elsif ARGV[0] == opt_sel_region[2] #us_east
  Dir.glob(results_dir_date+"/*"+opt_sel_region[2]+"*.xml") do |rb_file|
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
          inputter << target_address.to_s + "|" + target_ports.to_s + target_banner.to_s.gsub(/<\/*banner>/, '')
        rescue Exception => e
          puts "[-] Error On: #{target_address}"
          next
        end
      end
  end
elsif ARGV[0] == opt_sel_region[3] #us_west
  Dir.glob(results_dir_date+"/*"+opt_sel_region[3]+"*.xml") do |rb_file|
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
          inputter << target_address.to_s + "|" + target_ports.to_s + target_banner.to_s.gsub(/<\/*banner>/, '')
        rescue Exception => e
          puts "[-] Error On: #{target_address}"
          next
        end
      end
  end
elsif ARGV[0] == opt_sel_region[4] #south_america
  Dir.glob(results_dir_date+"/*"+opt_sel_region[4]+"*.xml") do |rb_file|
    xml = Nokogiri::XML.parse(open rb_file)
      xml.css('nmaprun host').each do |host|
        begin
          target_address = host.css('address').first['addr']
          target_ports = host.css('port').first['portid']
          if host.css('banner').empty?
            target_banner = 'NULL'
          elsif host.css('banner').to_s =~ /cert/
            target_banner = 'SSL Certificate'
          else
            target_banner = host.css('banner')
          end
          #inputter << target_address.to_s + "|" + target_ports.to_s + "|" + target_geo.latitude.to_s+"|"+target_geo.longitude.to_s + "|" + target_banner.to_s.gsub(/<\/*banner>/, '')
          inputter << [target_address.to_s,target_ports.to_s,target_banner.to_s.gsub(/<\/*banner>/, '')]
        rescue Exception => e
          puts "[-] Error On: #{target_address}"
          next
        end
      end
  end
elsif ARGV[0] == opt_sel_region[5] #all
  Dir.glob(results_dir_date+"/*.xml") do |rb_file|
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
          inputter << target_address.to_s + "|" + target_ports.to_s + target_banner.to_s.gsub(/<\/*banner>/, '')
        rescue Exception => e
          puts "[-] Error On: #{target_address}"
          next
        end
      end
  end
else puts opt_sel_err
end
puts "[+] Final counts generated at " + timenow.inspect + "."
puts "IP Count: " + inputter.count
puts "Port Count: " + inputter.count