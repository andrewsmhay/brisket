#!/usr/bin/env ruby

require 'rake'
require 'date'
require './lib/directories'
require './lib/ports'
require './lib/scanner'
require './lib/messages'
require './lib/naming'

opt_sel = ['remote', 'apps', 'web', 'db','special', 'ms', 'mail', 'all']
scan_sel = ['masscan','nmap','zmap']
commands = []

ARGV.each {|arg| commands << arg}

if ARGV[1] == scan_sel[0]
  if ARGV[0] == opt_sel[0]  
    Dir.foreach(Directories.data_dir) do |item|
      next if item == '.' or item == '..'
        item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
        item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
        system(Scanner.masscmd + " -p" + Ports.remote_ports + Directories.include_file_cmd + item + " " + Scanner.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
    end
  	puts Messages.conf_txt
  elsif ARGV[0] == opt_sel[1]
  	Dir.foreach(Directories.data_dir) do |item|
  		next if item == '.' or item == '..'
    		item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
    		item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
    		system(Scanner.masscmd + " -p" + Ports.app_ports + Directories.include_file_cmd + item + " " + Scanner.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
  	end	
  	puts Messages.conf_txt	
  elsif ARGV[0] == opt_sel[2]
  	Dir.foreach(Directories.data_dir) do |item|
  		next if item == '.' or item == '..'
    		item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
    		item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
    		system(Scanner.masscmd + " -p" + Ports.web_ports + Directories.include_file_cmd + item + " " + Scanner.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
  	end	
  	puts Messages.conf_txt	
  elsif ARGV[0] == opt_sel[3]
  	Dir.foreach(Directories.data_dir) do |item|
  		next if item == '.' or item == '..'
    		item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
    		item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
    		system(Scanner.masscmd + " -p" + Ports.db_ports + Directories.include_file_cmd + item + " " + Scanner.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
  	end	
  	puts Messages.conf_txt	
  elsif ARGV[0] == opt_sel[4]
    Dir.foreach(Directories.data_dir) do |item|
      next if item == '.' or item == '..'
        item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
        item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
        system(Scanner.masscmd + " -p" + Ports.special_ports + Directories.include_file_cmd + item + " " + Scanner.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
    end
    puts Messages.conf_txt
  elsif ARGV[0] == opt_sel[5]
    Dir.foreach(Directories.data_dir) do |item|
      next if item == '.' or item == '..'
        item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
        item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
        system(Scanner.masscmd + " -p" + Ports.ms_ports + Directories.include_file_cmd + item + " " + Scanner.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
    end  
    puts Messages.conf_txt
  elsif ARGV[0] == opt_sel[6]
    Dir.foreach(Directories.data_dir) do |item|
      next if item == '.' or item == '..'
        item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
        item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
        system(Scanner.masscmd + " -p" + Ports.mail_ports + Directories.include_file_cmd + item + " " + Scanner.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
    end
    puts Messages.conf_txt
  elsif ARGV[0] == opt_sel[7]
  	Dir.foreach(Directories.data_dir) do |item|
  		next if item == '.' or item == '..'
    		item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
    		item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
    		system(Scanner.masscmd + " -p" + Ports.all_ports + Directories.include_file_cmd + item + " " + Scanner.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
  	end
  	puts Messages.conf_txt
  else puts Messages.trim_opt_sel_err
  end
elsif ARGV[1] == scan_sel[1]
  puts scan_sel[1] + " is not yet implemented..."
elsif ARGV[1] == scan_sel[2]
  puts scan_sel[2] + " is not yet implemented..."
else puts Messages.trim_opt_sel_err
end