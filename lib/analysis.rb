class Analysis
	class << self
		
		def header
			"Date,Provider,Provider Region,IP,Port,Latt,Long,Country,Continent,Region,City"
		end

		def header_plus
			header+",Banner"
		end

		def ip_convert geo
      		GeoIP.new('GeoLiteCity.dat').city(geo.to_s)
      	end

      	def csp_masscan
      		/_masscan_(\w[^_]+)_/
      	end

      	def strip_port_regex
      		/portid\=\"(.+)\"/
      	end

      	def port_only_regex
			/(\d{1,5})/
		end

		def dateinput userdate
	      if userdate =~ /\-/
	        scan_date_ary = userdate.split("\-")
	      elsif userdate =~ /\//
	        scan_date_ary = userdate.split("\/")
	      elsif userdate =~ /\_/
	        scan_date_ary = userdate.split("\_")
	      end
	      @@date_y = scan_date_ary.pop
	      @@date_m = scan_date_ary.pop
	      @@date_d = scan_date_ary.pop
	      nil
	    end

	    def scan_date
	      @@date_y+"/"+@@date_m+"/"+@@date_d
	    end

	    def us_date
	      @@date_d+"/"+@@date_m+"/"+@@date_y
	    end

      	def results(strip_ip, csp, port_only, target_geo, us_date)
      		puts us_date+","+
      		csp.gsub( /\_\w[^\_]\_/, '')+","+
      		strip_ip+","+
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