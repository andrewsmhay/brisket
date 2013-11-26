#!/usr/bin/env ruby
$LOAD_PATH << '/home/scanner/brisket/lib'
require 'messages'
require 'archive'
require 'naming'
require 'date'
require 'directories'
require 'net/scp'
require 'net/ssh'

f = File.open(Directories.brisket_log, 'a+')
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