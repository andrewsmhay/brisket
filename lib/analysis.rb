class Analysis
	class << self
		
		def header
			"Date,Provider,Region,IP,Latt,Long,Port"
		end

		def header_plus
			header+",Banner"
		end

		def ip_convert geo
      		GeoIP.new('GeoLiteCity.dat').city(geo)
      	end

    end
end