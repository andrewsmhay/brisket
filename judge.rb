#!/usr/bin/env ruby
$LOAD_PATH << '/Users/scanner/brisket/lib'
require 'analysis'
require 'directory'

commands = []
ARGV.each {|arg| commands << arg}
# [0]=type, [1]=date in D/M/YYYY
# ./smoke_ring.rb masscan 3/12/2013

Analysis.dateinput ARGV[1]

rb_file_location = "./analysis/"+Analysis.scan_date+"/"
rb_file_master = Dir.glob(rb_file_location+"*"+ARGV[0]+"*")

# Split scan, banner, and title XML files into separate files
# for i in {6..10}; do ./smoke_ring.rb masscan $i/1/2014; done

system("./smoke_ring.rb "+ARGV[0]+" "+ARGV[1])

system("./mop.rb "+ARGV[0]+" "+ARGV[1])
# Convert to csv
# for i in {6..10}; do ./mop.rb masscan $i/1/2014; done
# for i in {6..10}; do ./mop.rb zmap $i/1/2014; done

# Strip special language chars
# for i in `ls -1`; do iconv -c -f utf8 -t ascii $i > converted_$i; done

# Create 
# for i in `ls -1 banner*masscan_aws_gov*`; do cat $i | egrep -v "Date" >> ~/stats/inprogress/gov/banner_aws_gov_1_1_2014.csv; done

# Create master 'aws' CSV file for the date of the directory
# for i in `ls -1 *masscan*aws*.csv | egrep -v banner | egrep -v title`; do cat $i | egrep -v "Date" >> aws/aws_10_1_2014.csv; done
