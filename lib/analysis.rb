class Analysis
	class << self
		
		def header
			"Date,Provider,Region,IP,Latt,Long,Port"
		end

		def header_plus
			header+",Banner"
		end

		def stripip
			to_s.gsub(/\<address addr\=\"/, '').gsub(/\"\saddrtype\=\"ipv4\"\/\>/, '')
		end

		def nmap_rule_name
			root["nmaprun"]
		end
	end
end