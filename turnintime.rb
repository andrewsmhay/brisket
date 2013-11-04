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
          elsif host.css('banner').to_s =~ /cert/
            target_banner = 'SSL Certificate'
          else
            target_banner = host.css('banner')
          end
          inputter << [target_address.to_s,target_ports.to_s,target_banner.to_s.gsub(/<\/*banner>/, '')]
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
          target_ports = host.css('port').first['portid']
          if host.css('banner').empty?
            target_banner = 'NULL'
          elsif host.css('banner').to_s =~ /cert/
            target_banner = 'SSL Certificate'
          else
            target_banner = host.css('banner')
          end
          inputter << [target_address.to_s,target_ports.to_s,target_banner.to_s.gsub(/<\/*banner>/, '')]
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
          target_ports = host.css('port').first['portid']
          if host.css('banner').empty?
            target_banner = 'NULL'
          elsif host.css('banner').to_s =~ /cert/
            target_banner = 'SSL Certificate'
          else
            target_banner = host.css('banner')
          end
          inputter << [target_address.to_s,target_ports.to_s,target_banner.to_s.gsub(/<\/*banner>/, '')]
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
          target_ports = host.css('port').first['portid']
          if host.css('banner').empty?
            target_banner = 'NULL'
          elsif host.css('banner').to_s =~ /cert/
            target_banner = 'SSL Certificate'
          else
            target_banner = host.css('banner')
          end
          inputter << [target_address.to_s,target_ports.to_s,target_banner.to_s.gsub(/<\/*banner>/, '')]
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
          target_ports = host.css('port').first['portid']
          if host.css('banner').empty?
            target_banner = 'NULL'
          elsif host.css('banner').to_s =~ /cert/
            target_banner = 'SSL Certificate'
          else
            target_banner = host.css('banner')
          end
          inputter << [target_address.to_s,target_ports.to_s,target_banner.to_s.gsub(/<\/*banner>/, '')]
        rescue Exception => e
          puts "[-] Error On: #{target_address}"
          next
        end
      end
  end
else puts opt_sel_err
end
puts "[+] Final counts generated at " + timenow.inspect + "."
ip_ary = []
inputter.each {|ip_num| ip_ary << ip_num[0] }
puts "IP Count: " + ip_ary.uniq.count_to_s

port_ary = []
inputter.each {|port_num| port_ary << port_num[1] }
puts "Port Count: " + port_ary.count.to_s