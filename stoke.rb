#!/usr/bin/env ruby
$LOAD_PATH << '/home/scanner/brisket/lib'
require 'directories'
require 'messages'
require 'naming'
require 'options'
require 'bnodes'
require 'net/ssh'
require 'minigit'


i=0
git = MiniGit.new(Directories.working_dir)

puts Messages.update_git
while i < Bnodes.brisket_nodes.count
	puts Net::SSH.start(Bnodes.brisket_nodes[i], 'scanner') #do |ssh|


	i += 1
end
puts Messages.git_pull
git.pull