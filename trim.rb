#!/usr/bin/env ruby

require 'rake'
require 'date'
require './lib/directories'
=begin
class Directories
  def self.working_dir
    "/home/scanner/brisket"
  end
  def self.conf_dir
    working_dir + "/conf/"
  end
  def self.data_dir
    working_dir + "/data/"
  end
  def self.dir_date
    Date.today.year.to_s+"/"+Date.today.month.to_s+"/"+Date.today.day.to_s+"/"
  end
  def self.results_dir
    working_dir+"/results/"
  end
  def self.results_dir_date
    results_dir + dir_date
  end
  def self.results_out
    "-oX " + results_dir_date
  end
  def self.include_file_cmd
    " --includefile " + data_dir
  end
end
=end
class Ports
  def self.remote_ports
    "22,23,513,3389,5900"
  end
  def self.app_ports
    "21,69,53,389,161,1984"
  end
  def self.ms_ports
    "135,137,138,139,389,445"
  end
  def self.mail_ports
    "25,110,995,993,465"
  end
  def self.web_ports
    "80,443,8080,8443,8888"
  end
  def self.db_ports
    "1433,1521,3306,5432"
  end
  def self.special_ports
    # IRC, tor, tcp syslog, DNP3 (SCADA networks)
    "6667,9050,1514,20000"
  end
  def self.all_ports
    remote_ports + "," + app_ports + "," + web_ports + "," + db_ports + "," + special_ports + "," + ms_ports + "," + mail_ports
  end
end


class Messages
  def self.opt_sel_err
    "[-] Usage: ./trim.rb <remote|apps|web|db|all> <masscan|nmap|zmap>"
  end
  def self.timenow
    Time.new
  end
  def self.conf_txt
    "[+] Configuration files successfully generated for " +ARGV[0]+ " ports at " +timenow.inspect + "."
  end
end

class Masscan
  def self.rate
    "2337" #restriction by the service provider is 4000/second
  end
  def self.rate_cmd
    "--rate " + rate
  end
  def self.cmd
    "/usr/local/sbin/masscan"
  end
end

class Naming
  def self.hostname
    `hostname -s`.chomp
  end
end

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
        system(Masscan.cmd + " -p" + Ports.remote_ports + Directories.include_file_cmd + item + " " + Masscan.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
    end
  	puts Messages.conf_txt
  elsif ARGV[0] == opt_sel[1]
  	Dir.foreach(Directories.data_dir) do |item|
  		next if item == '.' or item == '..'
    		item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
    		item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
    		system(Masscan.cmd + " -p" + Ports.app_ports + Directories.include_file_cmd + item + " " + Masscan.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
  	end	
  	puts Messages.conf_txt	
  elsif ARGV[0] == opt_sel[2]
  	Dir.foreach(Directories.data_dir) do |item|
  		next if item == '.' or item == '..'
    		item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
    		item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
    		system(Masscan.cmd + " -p" + Ports.web_ports + Directories.include_file_cmd + item + " " + Masscan.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
  	end	
  	puts Messages.conf_txt	
  elsif ARGV[0] == opt_sel[3]
  	Dir.foreach(Directories.data_dir) do |item|
  		next if item == '.' or item == '..'
    		item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
    		item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
    		system(Masscan.cmd + " -p" + Ports.db_ports + Directories.include_file_cmd + item + " " + Masscan.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
  	end	
  	puts Messages.conf_txt	
  elsif ARGV[0] == opt_sel[4]
    Dir.foreach(Directories.data_dir) do |item|
      next if item == '.' or item == '..'
        item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
        item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
        system(Masscan.cmd + " -p" + Ports.special_ports + Directories.include_file_cmd + item + " " + Masscan.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
    end
    puts Messages.conf_txt
  elsif ARGV[0] == opt_sel[5]
    Dir.foreach(Directories.data_dir) do |item|
      next if item == '.' or item == '..'
        item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
        item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
        system(Masscan.cmd + " -p" + Ports.ms_ports + Directories.include_file_cmd + item + " " + Masscan.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
    end  
    puts Messages.conf_txt
  elsif ARGV[0] == opt_sel[6]
    Dir.foreach(Directories.data_dir) do |item|
      next if item == '.' or item == '..'
        item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
        item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
        system(Masscan.cmd + " -p" + Ports.mail_ports + Directories.include_file_cmd + item + " " + Masscan.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
    end
    puts Messages.conf_txt
  elsif ARGV[0] == opt_sel[7]
  	Dir.foreach(Directories.data_dir) do |item|
  		next if item == '.' or item == '..'
    		item_dir = Directories.conf_dir + ARGV[1] + "_" + item.gsub(/(.ip)/, '.conf')
    		item_xml = Naming.hostname + "_" + ARGV[1] + "_" + item.gsub(/(.ip)/, '.xml')
    		system(Masscan.cmd + " -p" + Ports.all_ports + Directories.include_file_cmd + item + " " + Masscan.rate_cmd + " " + Directories.results_out + item_xml + " --echo > " + item_dir)
  	end
  	puts Messages.conf_txt
  else puts Messages.opt_sel_err
  end
elsif ARGV[1] == scan_sel[1]
  puts scan_sel[1] + " is not yet implemented..."
elsif ARGV[1] == scan_sel[2]
  puts scan_sel[2] + " is not yet implemented..."
else puts Messages.opt_sel_err
end