#!/usr/bin/env ruby
require 'nokogiri'
require 'geoip'

# Special thanks to PentestGeek - http://www.pentestgeek.com/2012/08/23/creds-or-hash-where-the-admin-at/
opt_sel_err = "[-] Usage: ./crutch.rb <apac|europe|us_east|us_west|south_america|all> <yyyy/mm/dd>"
working_dir = "/home/scanner/brisket/"
results_dir = working_dir+"/results/"
dir_date = ARGV[1]
#dir_date = Date.today.year.to_s+"/"+Date.today.month.to_s+"/"+Date.today.day.to_s+"/"
results_dir_date = results_dir + dir_date + "/"
item_dir= []
opt_sel_region = ['apac','europe','us_east','us_west','south_america','all']
commands = []
inputter = []
ARGV.each {|arg| commands << arg}
timenow = Time.new

puts "[+] Beginning conversion..."
if ARGV[0] == opt_sel_region[0] #apac
  Dir.glob(results_dir_date+"/*"+opt_sel_region[0]+"*.xml") do |rb_file|
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
    File.open(rb_file+".csv", "w"){ |f| f.write(inputter)}
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
          inputter << target_address.to_s + "|" + target_ports.to_s + "|" + target_geo.latitude.to_s+"|"+target_geo.longitude.to_s + "|" + target_banner.to_s.gsub(/<\/*banner>/, '')
        rescue Exception => e
          puts "[-] Error On: #{target_address}"
          next
        end
      end
    File.open(rb_file+".csv", "w"){ |f| f.write(inputter)}
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
          inputter << target_address.to_s + "|" + target_ports.to_s + "|" + target_geo.latitude.to_s+"|"+target_geo.longitude.to_s + "|" + target_banner.to_s.gsub(/<\/*banner>/, '')
        rescue Exception => e
          puts "[-] Error On: #{target_address}"
          next
        end
      end
    File.open(rb_file+".csv", "w"){ |f| f.write(inputter)}
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
          inputter << target_address.to_s + "|" + target_ports.to_s + "|" + target_geo.latitude.to_s+"|"+target_geo.longitude.to_s + "|" + target_banner.to_s.gsub(/<\/*banner>/, '')
        rescue Exception => e
          puts "[-] Error On: #{target_address}"
          next
        end
      end
    File.open(rb_file+".csv", "w"){ |f| f.write(inputter)}
  end
elsif ARGV[0] == opt_sel_region[4] #south_america
  Dir.glob(results_dir_date+"/*"+opt_sel_region[4]+"*.xml") do |rb_file|
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
          inputter << target_address.to_s + "|" + target_ports.to_s + "|" + target_geo.latitude.to_s+"|"+target_geo.longitude.to_s + "|" + target_banner.to_s.gsub(/<\/*banner>/, '')
        rescue Exception => e
          puts "[-] Error On: #{target_address}"
          next
        end
      end
    File.open(rb_file+".csv", "w"){ |f| f.write(inputter)}
  end
else puts opt_sel_err
end
inputter.each do |new_input|
      File.open(results_dir_date+"andrew.csv", "w"){ |f| f.write(new_input)}
    end
puts "[+] Analysis and conversion of " + ARGV[0] + " completed at " + timenow.inspect + "."