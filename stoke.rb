#!/usr/bin/env ruby
$LOAD_PATH << './lib'
require 'directories'
require 'messages'
require 'naming'
require 'options'
require 'bnodes'
require 'socket'
require 'net/ping'

commands = []
ARGV.each {|arg| commands << arg}
port = 22

i=0

if ARGV[0] == 'git'
puts Messages.update_git
	while i < Bnodes.brisket_nodes.count
		puts Messages.ssh_to_bnode+Bnodes.brisket_nodes[i]
		p1 = Net::Ping::External.new(Bnodes.brisket_nodes[i])
		if p1.ping?
			puts Messages.git_pull
			system("ssh scanner@'#{Bnodes.brisket_nodes[i]}' \"sh -c 'cd /home/scanner/brisket && git pull'\"")
			system("ssh scanner@'#{Bnodes.brisket_nodes[i]}' \"sh -c 'cd /home/scanner/masscan && git pull'\"")
			system("ssh scanner@'#{Bnodes.brisket_nodes[i]}' \"sh -c 'cd /home/scanner/zmap && git pull'\"")
		else puts "[+] "+Bnodes.brisket_nodes[i]+" is down..."
		end
		i+=1
end
elsif ARGV[0] == 'update'
puts Messages.update_git
	while i < Bnodes.brisket_nodes.count
		puts Messages.ssh_to_bnode+Bnodes.brisket_nodes[i]
		p1 = Net::Ping::External.new(Bnodes.brisket_nodes[i])
		if p1.ping?
			system("ssh scanner@'#{Bnodes.brisket_nodes[i]}' \"sh -c 'cd /home/scanner/brisket && git pull'\"")
			system("ssh scanner@'#{Bnodes.brisket_nodes[i]}' \"sh -c 'cd /home/scanner/masscan && git pull && make'\"")
			system("ssh scanner@'#{Bnodes.brisket_nodes[i]}' \"sh -c 'cd /home/scanner/zmap && git pull'\"")
		else puts "[+] "+Bnodes.brisket_nodes[i]+" is down..."
		end
		i+=1
end
elsif ARGV[0] == 'space'
	while i < Bnodes.brisket_nodes.count
		puts Messages.ssh_to_bnode+Bnodes.brisket_nodes[i]
		p1 = Net::Ping::External.new(Bnodes.brisket_nodes[i])
		if p1.ping?
			puts Messages.free_space
			system("ssh scanner@'#{Bnodes.brisket_nodes[i]}' \"df -BM\"")
		else puts "[+] "+Bnodes.brisket_nodes[i]+" is down..."
		end
		i+=1
	end
elsif ARGV[0] == 'logs'
	while i < Bnodes.brisket_nodes.count
		puts Messages.ssh_to_bnode+Bnodes.brisket_nodes[i]
		p1 = Net::Ping::External.new(Bnodes.brisket_nodes[i])
		if p1.ping?
			puts Messages.log_file
			system("ssh scanner@'#{Bnodes.brisket_nodes[i]}' \"tail -10 /var/log/brisket.log\"")
		else puts "[+] "+Bnodes.brisket_nodes[i]+" is down..."
		end
		i+=1
	end
elsif ARGV[0] == 'proc'
	while i < Bnodes.brisket_nodes.count
		puts Messages.ssh_to_bnode+Bnodes.brisket_nodes[i]
		p1 = Net::Ping::External.new(Bnodes.brisket_nodes[i])
		if p1.ping?
			puts Messages.proc_listing
			system("ssh scanner@'#{Bnodes.brisket_nodes[i]}' \"ps aux | grep '[r]ub'\"")
		else puts "[+] "+Bnodes.brisket_nodes[i]+" is down..."
		end
		i+=1
	end
elsif ARGV[0] == 'archive'
	while i < Bnodes.brisket_nodes.count
		puts Messages.ssh_to_bnode+Bnodes.brisket_nodes[i]
		p1 = Net::Ping::External.new(Bnodes.brisket_nodes[i])
		if p1.ping?
			puts Messages.archive_listing
			system("ssh scanner@'#{Bnodes.brisket_nodes[i]}' \"ls -lah *.bz2\"")
		else puts "[+] "+Bnodes.brisket_nodes[i]+" is down..."
		end
		i+=1
	end
elsif ARGV[0] == 'files' && ARGV[1] == 'today'
	while i < Bnodes.brisket_nodes.count
		puts Messages.ssh_to_bnode+Bnodes.brisket_nodes[i]
		p1 = Net::Ping::External.new(Bnodes.brisket_nodes[i])
		if p1.ping?
			system("ssh scanner@'#{Bnodes.brisket_nodes[i]}' \"ls -1 #{Directories.results_dir_date} | wc -l\"")
		else puts "[+] "+Bnodes.brisket_nodes[i]+" is down..."
		end 
		i+=1
	end
elsif ARGV[0] == 'files' && ARGV[1] == 'tomorrow'
	while i < Bnodes.brisket_nodes.count
		puts Messages.ssh_to_bnode+Bnodes.brisket_nodes[i]
		p1 = Net::Ping::External.new(Bnodes.brisket_nodes[i])
		if p1.ping?
			system("ssh scanner@'#{Bnodes.brisket_nodes[i]}' \"ls -1 #{Directories.results_dir+Directories.dir_date_tomorrow} | wc -l\"")
		else puts "[+] "+Bnodes.brisket_nodes[i]+" is down..."
		end 
		i+=1
	end
elsif ARGV[0] == 'status'
	while i < Bnodes.brisket_nodes.count
		p1 = Net::Ping::External.new(Bnodes.brisket_nodes[i])
		if p1.ping?
			s = TCPSocket.open(Bnodes.brisket_nodes[i], port)	
			puts "[+] "+Bnodes.brisket_nodes[i]+" is up..."
			s.close
		else puts "[+] "+Bnodes.brisket_nodes[i]+" is down..."
		end
		i+=1
	end
else puts "[+] Invalid command..."
end