#!/usr/bin/env ruby
$LOAD_PATH << './lib'
require 'messages'
require 'archive'
require 'naming'
require 'date'
require 'directories'
#require 'net/scp'
#require 'net/ssh'
require 'bnodes'

f = File.open(Directories.brisket_log, 'a+')

cooker_key = "-i /Users/andrewsmhay/.ssh/cooker"

commands = []
ARGV.each {|arg| commands << arg}

if ARGV[0] == "prep"
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
		system("scp "+cooker_key+" scanner@'#{Bnodes.brisket_nodes[i]}':*.bz2 ./results/.")
		i+=1
	end
elsif ARGV[0] == "clean"
	i=0
	puts Archive.cleanup
	f.puts Messages.syslog_stamp+Archive.cleanup
	while i < Bnodes.brisket_nodes.count
		puts Messages.ssh_to_bnode+Bnodes.brisket_nodes[i]
		system("ssh "+cooker_key+" scanner@'#{Bnodes.brisket_nodes[i]}' \"rm -Rf *.bz2\"")
		i+=1
	end
else 
		puts Messages.brisket_error
		f.puts Messages.syslog_stamp+Messages.brisket_error
end
