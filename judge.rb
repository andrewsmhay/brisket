#!/usr/bin/env ruby
$LOAD_PATH << '/Users/scanner/brisket/lib'
require 'analysis'
require 'directories'

commands = []
ARGV.each {|arg| commands << arg}
# [0]=type, [1]=date in D/M/YYYY
# ./smoke_ring.rb masscan 3/12/2013 
# --testrun
# --full
# --extract
# --splitxml
# --convert
# --iconv

Analysis.dateinput ARGV[1]

extract_file_location = Directories.mac_scanner_dir+"/results/"
extract_file_master = Dir.glob(extract_file_location+"*"+Analysis.file_date+".tar.bz2")

#if extract_file_master.each.nil
extract_file_master.each do |tarball|
	system("tar xvfj "+tarball+" --strip-components 4 -C "+extract_file_location)
	system("mv "+tarball+" "+extract_file_location+"extracted")
end

rb_file_location = Directories.mac_scanner_dir+"/analysis/"+Analysis.scan_date+"/"
rb_file_master = Dir.glob(rb_file_location+"*"+ARGV[0]+"*")

# Split scan, banner, and title XML files into separate files
if ARGV[0] == "masscan"
	puts "[+] Running smoke_ring.rb..."
	system(Directories.mac_scanner_dir+"/smoke_ring.rb masscan "+ARGV[1])
end
# Convert to csv
puts "[+] Converting files to csv format..."
system(Directories.mac_scanner_dir+"/mop.rb "+ARGV[0]+" "+ARGV[1])

# Strip special language chars
# for i in `ls -1`; do iconv -c -f utf8 -t ascii $i > converted_$i; done

# Create 
# for i in `ls -1 banner*masscan_aws_gov*`; do cat $i | egrep -v "Date" >> ~/stats/inprogress/gov/banner_aws_gov_1_1_2014.csv; done

# Create master 'aws' CSV file for the date of the directory
# for i in `ls -1 *masscan*aws*.csv | egrep -v banner | egrep -v title`; do cat $i | egrep -v "Date" >> aws/aws_10_1_2014.csv; done


# sort -u -t ',' -k4,5 converted_aws_2_1_2014.csv > sorted_aws_2_1_2014.csv
