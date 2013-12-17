class Analysis
	class << self
		
		def header
			"Date,Scanner,CSP,IP,Port,Latt,Long,Country,Continent,Region,City"
		end

		def header_plus
			header+",Banner"
		end

		def ip_convert geo
      		GeoIP.new('GeoLiteCity.dat').city(geo.to_s)
      	end

      	def scanner_name_regex
      		/\d+\/\d+\/\d+\/(\w[^_]+)_/
      	end

      	def csp_masscan_regex
      		/_masscan_(\w[^_]+)_/
      	end

      	def csp_zmap_regex
      		/_zmap_(\w[^_]+)_/
      	end

      	def strip_port_regex
      		/portid\=\"(.+)\"/
      	end

      	def port_only_regex
			/(\d{1,5})/
		end

		def ip_strip
			/(\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b)/
		end

		def scanner_host sname
			if sname == 'vps7026'
				scanner_host_ip = '46.38.48.66'
			elsif sname == 'vps199'
				scanner_host_ip = '199.175.51.99'
			elsif sname == 'vps7094'
				scanner_host_ip = '66.85.144.237'
			elsif sname == 'vps7095'
				scanner_host_ip = '109.68.190.145'
			elsif sname == 'vps7220'
				scanner_host_ip = '173.244.206.19'
			elsif sname == 'vps7221'
				scanner_host_ip = '66.85.140.77'
			elsif sname == 'vps7222'
				scanner_host_ip = '109.68.191.26'
			elsif sname == 'vps7237'
				scanner_host_ip = '173.244.206.13'
			elsif sname == 'vps7292'
				scanner_host_ip = '66.85.140.110'
			elsif sname == 'vps7293'
				scanner_host_ip = '173.244.215.194'
			elsif sname == 'honghong'
				scanner_host_ip = '119.9.74.172'
			elsif sname == 'syd'
				scanner_host_ip = '119.9.46.159'
			elsif sname == 'piscan1'
				scanner_host_ip = '192.168.1.192'
			else scanner_host_ip = sname
			end
			@@scanner_ip = scanner_host_ip
		end

		def thescannerip
			@@scanner_ip
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

      	def results(scanner_name, strip_ip, csp, port_only, target_geo, us_date)
      		puts us_date+","+
      		scanner_name+","+
      		csp+","+
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