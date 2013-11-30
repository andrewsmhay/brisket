#!/usr/bin/env ruby
$LOAD_PATH << './lib'
require 'directories'
require 'messages'
require 'naming'
require 'options'
require 'bnodes'

=begin
commands = []
ARGV.each {|arg| commands << arg}
=end

i=0
puts Messages.update_git
while i < Bnodes.brisket_nodes.count
	puts Messages.ssh_to_bnode+Bnodes.brisket_nodes[i]
	puts Messages.git_pull
	system("ssh scanner@'#{Bnodes.brisket_nodes[i]}' \"sh -c 'cd /home/scanner/brisket && git pull'\"")
	i+=1
end