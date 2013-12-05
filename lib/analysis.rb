class Analysis
	class << self
		
		def header
			"Date,Provider,Region,IP,Latt,Long,Port"
		end

		def header_plus
			header+",Banner"
		end

		def ip_convert geo
      		GeoIP.new('GeoLiteCity.dat').city(geo.to_s)
      	end

      	def results strip_ip port_only
      		strip_ip+","+
      		port_only+","+
      		ip_convert.latitude.to_s+","+
      		ip_convert.longitude.to_s+","+
      		ip_convert.country_name.to_s+","+
      		ip_convert.continent_code.to_s+","+
      		ip_convert.region_name.to_s+","+
      		ip_convert.city_name.to_s
      	end
    end
end