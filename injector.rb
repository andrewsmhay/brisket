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

ec2 = AWS::EC2.new(
		    :access_key_id => '', # => Enter your own EC2 Access Key ID
		    :secret_access_key => '') # => Enter your own EC2 Secret Access Key

master_instance = "" # => enter your instance ID
brisket_mother = ec2.instances[master_instance]

f = File.open(Directories.brisket_log, 'a+')

if brisket_mother.status == ":stopped"
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
elsif brisket_mother.status == ":running"
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
else f.puts Messages.syslog_stamp+Messages.brisket_error
end