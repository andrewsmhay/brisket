class Analysis
	class << self
		
		def header
			"Date,Provider,Region,IP,Latt,Long,Port"
		end

		def header_plus
			header+",Banner"
		end

		def ip_convert geo
      	geo.each do |ip|
      		GeoIP.new('GeoLiteCity.dat').city(ip)
      	end
      	end

    end
end