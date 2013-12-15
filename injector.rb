#!/usr/bin/env ruby
$LOAD_PATH << '/home/scanner/brisket/lib'
require 'messages'
require 'archive'
require 'naming'
require 'date'
require 'directories'
require 'net/scp'
require 'net/ssh'
require 'aws-sdk'
require 'bnodes'

ec2 = AWS::EC2.new(
:access_key_id => '',
:secret_access_key => '')
master_instance = ""
brisket_mother = ec2.instances[master_instance]

f = File.open(Directories.brisket_log, 'a+')

commands = []
ARGV.each {|arg| commands << arg}

if ARGV[0] == "aws"
	if brisket_mother.status.to_s == "stopped"
		puts Messages.brisket_start
		f.puts Messages.syslog_stamp+Messages.brisket_start
	  	
	  	brisket_mother.start
	  	
	  	puts Messages.brisket_started
	  	f.puts Messages.syslog_stamp+Messages.brisket_started
	  	sleep(5.minutes)

	  	puts Archive.prep
		f.puts Messages.syslog_stamp+Archive.prep

		Archive.tar

		puts Archive.copyfile
		f.puts Messages.syslog_stamp+Archive.copyfile

		Archive.scp

		puts Archive.cleanup
		f.puts Messages.syslog_stamp+Archive.cleanup

		Archive.cleanup_zip

		puts Archive.cleanup_done
		f.puts Messages.syslog_stamp+Archive.cleanup_done

		f.close
	elsif brisket_mother.status.to_s == "running"
		puts Messages.brisket_started
		f.puts Messages.syslog_stamp+Messages.brisket_started

		puts Archive.prep
		f.puts Messages.syslog_stamp+Archive.prep

		Archive.tar

		puts Archive.copyfile
		f.puts Messages.syslog_stamp+Archive.copyfile

		Archive.scp

		puts Archive.cleanup
		f.puts Messages.syslog_stamp+Archive.cleanup

		Archive.cleanup_zip

		puts Archive.cleanup_done
		f.puts Messages.syslog_stamp+Archive.cleanup_done

		f.close
	else 
		puts Messages.brisket_error
		f.puts Messages.syslog_stamp+Messages.brisket_error
	end
elsif ARGV[0] == "prep"
	puts Archive.prep
	f.puts Messages.syslog_stamp+Archive.prep

	Archive.tar

	puts Archive.cleanup
	f.puts Messages.syslog_stamp+Archive.cleanup

	Archive.cleanup_dir

	puts Archive.cleanup_done
	f.puts Messages.syslog_stamp+Archive.cleanup_done

	f.close
elsif ARGV[0] == "pull"
	i=0
	puts "[+] Pulling files from scanners..."
	f.puts Messages.syslog_stamp+"[+] Pulling files from scanners..."
	while i < Bnodes.brisket_nodes.count
		puts Messages.ssh_to_bnode+Bnodes.brisket_nodes[i]
		system("scp scanner@'#{Bnodes.brisket_nodes[i]}':*.bz2 .")
		i+=1
	end
elsif ARGV[0] == "clean"
	i=0
	puts Archive.cleanup
	f.puts Messages.syslog_stamp+Archive.cleanup
	while i < Bnodes.brisket_nodes.count
		puts Messages.ssh_to_bnode+Bnodes.brisket_nodes[i]
		system("ssh scanner@'#{Bnodes.brisket_nodes[i]}' \"rm -Rf *.bz2\"")
		i+=1
	end
else 
		puts Messages.brisket_error
		f.puts Messages.syslog_stamp+Messages.brisket_error
end
