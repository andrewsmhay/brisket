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

      	def strip_port
      		/portid\=\"(.+)\"/.match(portarea.to_s)
      	end

      	def port_only
			/(\d{1,5})/.match(strip_port.to_s).to_s
		end

      	def results(strip_ip, port_only, target_geo)
      		puts strip_ip+","+
      		port_only+","+
      		target_geo.latitude.to_s+","+
      		target_geo.longitude.to_s+","+
      		target_geo.country_name.to_s+","+
      		target_geo.continent_code.to_s+","+
      		target_geo.region_name.to_s+","+
      		target_geo.city_name.to_s
      	end
    end
end