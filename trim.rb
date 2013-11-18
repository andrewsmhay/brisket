#!/usr/bin/env ruby
$LOAD_PATH << '/home/scanner/brisket/lib'
require 'rake'
require 'date'
require 'directories'
require 'ports'
require 'scanner'
require 'messages'
require 'naming'
require 'options'

commands = []

ARGV.each {|arg| commands << arg}

if ARGV[1] == Options.scan_sel[0]
  if ARGV[0] == Options.opt_sel_ports[0]  
    Dir.foreach(Directories.data_dir) do |item|
      next if item == '.' or item == '..'
        item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
        item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
        system(Scanner.masscmd + " -p" + Ports.remote_ports + Directories.include_file_cmd + item + " " + Scanner.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
    end
  elsif ARGV[0] == Options.opt_sel_ports[1]
  	Dir.foreach(Directories.data_dir) do |item|
  		next if item == '.' or item == '..'
    		item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
    		item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
    		system(Scanner.masscmd + " -p" + Ports.app_ports + Directories.include_file_cmd + item + " " + Scanner.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
  	end	
  elsif ARGV[0] == Options.opt_sel_ports[2]
  	Dir.foreach(Directories.data_dir) do |item|
  		next if item == '.' or item == '..'
    		item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
    		item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
    		system(Scanner.masscmd + " -p" + Ports.web_ports + Directories.include_file_cmd + item + " " + Scanner.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
  	end	
  elsif ARGV[0] == Options.opt_sel_ports[3]
  	Dir.foreach(Directories.data_dir) do |item|
  		next if item == '.' or item == '..'
    		item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
    		item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
    		system(Scanner.masscmd + " -p" + Ports.db_ports + Directories.include_file_cmd + item + " " + Scanner.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
  	end	
  elsif ARGV[0] == Options.opt_sel_ports[4]
    Dir.foreach(Directories.data_dir) do |item|
      next if item == '.' or item == '..'
        item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
        item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
        system(Scanner.masscmd + " -p" + Ports.special_ports + Directories.include_file_cmd + item + " " + Scanner.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
    end
  elsif ARGV[0] == Options.opt_sel_ports[5]
    Dir.foreach(Directories.data_dir) do |item|
      next if item == '.' or item == '..'
        item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
        item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
        system(Scanner.masscmd + " -p" + Ports.ms_ports + Directories.include_file_cmd + item + " " + Scanner.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
    end  
  elsif ARGV[0] == Options.opt_sel_ports[6]
    Dir.foreach(Directories.data_dir) do |item|
      next if item == '.' or item == '..'
        item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
        item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
        system(Scanner.masscmd + " -p" + Ports.mail_ports + Directories.include_file_cmd + item + " " + Scanner.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
    end
  elsif ARGV[0] == Options.opt_sel_ports[7]
  	Dir.foreach(Directories.data_dir) do |item|
  		next if item == '.' or item == '..'
    		item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
    		item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
    		system(Scanner.masscmd + " -p" + Ports.all_ports + Directories.include_file_cmd + item + " " + Scanner.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
  	end
  else puts Messages.trim_opt_sel_ports_err
  end

puts Messages.conf_txt
f = File.open(Directories.brisket_log, 'a+')
f.puts Messages.conf_sys_txt
f.puts Messages.conf_sys_dir
f.close

elsif ARGV[1] == Options.scan_sel[1]
  puts Options.scan_sel[1] + " does not require a configuration file to be created."
elsif ARGV[1] == Options.scan_sel[2]
  puts Options.scan_sel[2] + " does not require a configuration file to be created."
else puts Messages.trim_opt_sel_err
end