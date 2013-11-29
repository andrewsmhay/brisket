class Bnodes
	def do_tail( session, file )
  			session.open_channel do |channel|
    			channel.on_data do |ch, data|
      			puts "[#{file}] -> #{data}"
    		end
    		channel.exec "tail -10 #{file}"
  			end
		end
	class << self
		def brisket_nodes
			%w( 173.244.206.13
				109.68.191.26
				173.244.206.19
				178.63.114.74
				109.68.190.145
				66.85.144.237
				199.175.51.99
				46.38.48.66
				54.204.15.249 )			
		end
	end
end
