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

def do_tail( session, file )
  session.open_channel do |channel|
    channel.on_data do |ch, data|
      puts "[#{file}] -> #{data}"
    end
    channel.exec "tail -10 #{file}"
  end
end

puts Messages.update_git
while i < Bnodes.brisket_nodes.count
	Net::SSH.start( Bnodes.brisket_nodes[i], 'scanner' ) do |session|
		session.open_channel do |channel|
			channel.on_data do |ch, data|
				puts "[#{file}] -> #{data}"
			end
			channel.exec git.pull
		end
		#do_tail session, "/var/log/brisket.log"
	end
	i+=1
end

	Net::SSH.start.new(
		'#{Bnodes.brisket_nodes[i]}', 'scanner'
		)
		do |session|


	i += 1
end
puts Messages.git_pull
git.pull