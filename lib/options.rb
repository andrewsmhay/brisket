class Options
	class << self
		def opt_sel
			['apac','europe','us_east','us_west','south_america','us_all','all','gov']
		end

		def opt_sel_region
			['apac','eu','us_east','us_west','south_america','all']
		end

		def opt_sel_ports
			['remote', 'apps', 'web', 'db','special', 'ms', 'mail', 'all']
		end

		def prefix
			['masscan','nmap','zmap','nmap_virt','nmap_virt_host','nmap_virt_ping']
		end
		
		def scan_sel
			prefix
		end
		
		def postfix
			['.conf','.ip','.xml','.json']
		end
		
		def gov
			['aws_gov_us_west']
		end

		def gov_reg
			[prefix[0]+'_'+gov[0]+postfix[0]]
		end

		def gov_ip
			[gov[0]+postfix[1]]
		end
		
		def apac #and us_central to spread the load
			%w[ softlayer_apac
				aws_apac
				azure_apac
				dimension_data_apac
				huawei_apac
				linode_apac
				azure_us_central
				firehost_us_central
				gce_us_central
				linode_us_central
				softlayer_us_central
				tier3_us_central
			]
		end
		
		def apac_reg
			[prefix[0]+'_'+apac[0]+postfix[0],
			prefix[0]+'_'+apac[1]+postfix[0],
			prefix[0]+'_'+apac[2]+postfix[0],
			prefix[0]+'_'+apac[3]+postfix[0],
			prefix[0]+'_'+apac[4]+postfix[0],
			prefix[0]+'_'+apac[5]+postfix[0],
			prefix[0]+'_'+apac[6]+postfix[0],
			prefix[0]+'_'+apac[7]+postfix[0],
			prefix[0]+'_'+apac[8]+postfix[0],
			prefix[0]+'_'+apac[9]+postfix[0],
			prefix[0]+'_'+apac[10]+postfix[0],
			prefix[0]+'_'+apac[11]+postfix[0]]
		end
		
		def apac_ip
			[apac[0]+postfix[1],
			apac[1]+postfix[1],
			apac[2]+postfix[1],
			apac[3]+postfix[1],
			apac[4]+postfix[1],
			apac[5]+postfix[1],
			apac[6]+postfix[1],
			apac[7]+postfix[1],
			apac[8]+postfix[1],
			apac[9]+postfix[1],
			apac[10]+postfix[1],
			apac[11]+postfix[1]]
		end
		
		def eu
			%w[ aws_eu
				azure_europe_north
				azure_europe_west
				csc_eu_west
				digital_ocean_eu
				gce_eu_west
				gogrid_europe_north
				host_virtual_eu_west
				joyent_eu
				linode_eu_west
				softlayer_eu_west
				tier3_eu_west
			]
		end
		
		def europe_reg
			[prefix[0]+'_'+eu[0]+postfix[0],
			prefix[0]+'_'+eu[1]+postfix[0],
			prefix[0]+'_'+eu[2]+postfix[0],
			prefix[0]+'_'+eu[3]+postfix[0],
			prefix[0]+'_'+eu[4]+postfix[0],
			prefix[0]+'_'+eu[5]+postfix[0],
			prefix[0]+'_'+eu[6]+postfix[0],
			prefix[0]+'_'+eu[7]+postfix[0],
			prefix[0]+'_'+eu[8]+postfix[0],
			prefix[0]+'_'+eu[9]+postfix[0],
			prefix[0]+'_'+eu[10]+postfix[0],
			prefix[0]+'_'+eu[11]+postfix[0]]
		end
		
		def europe_ip
			[eu[0]+postfix[1],
			eu[1]+postfix[1],
			eu[2]+postfix[1],
			eu[3]+postfix[1],
			eu[4]+postfix[1],
			eu[5]+postfix[1],
			eu[6]+postfix[1],
			eu[7]+postfix[1],
			eu[8]+postfix[1],
			eu[9]+postfix[1],
			eu[10]+postfix[1],
			eu[11]+postfix[1]]
		end
		
		def na_east
			%w[	aws_us_east
				azure_us_east
				digital_ocean_us_east
				earthlink_us_east
				linode_us_east
				profitbricks_us_east
				softlayer_us_east
				tier3_us_east
				virtustream_us_east
			]
		end
		
		def north_america_reg_east
			[prefix[0]+'_'+na_east[0]+postfix[0],
			prefix[0]+'_'+na_east[1]+postfix[0],
			prefix[0]+'_'+na_east[2]+postfix[0],
			prefix[0]+'_'+na_east[3]+postfix[0],
			prefix[0]+'_'+na_east[4]+postfix[0],
			prefix[0]+'_'+na_east[5]+postfix[0],
			prefix[0]+'_'+na_east[6]+postfix[0],
			prefix[0]+'_'+na_east[7]+postfix[0],
			prefix[0]+'_'+na_east[8]+postfix[0]]
		end
		
		def na_east_ip
			[na_east[0]+postfix[1],
			na_east[1]+postfix[1],
			na_east[2]+postfix[1],
			na_east[3]+postfix[1],
			na_east[4]+postfix[1],
			na_east[5]+postfix[1],
			na_east[6]+postfix[1],
			na_east[7]+postfix[1],
			na_east[8]+postfix[1]]
		end
		
		def na_west
			%w[	aws_gov_us_west
				aws_us_west
				azure_us_west
				digital_ocean_us_west
				dimension_data_us_west
				gogrid_us_west
				host_virtual_us_west
				hp_us_west
				joyent_us_west
				profitbricks_us_west
				softlayer_us_west
				tier3_us_west
			]
		end
		
		def north_america_reg_west
			[prefix[0]+'_'+na_west[0]+postfix[0],
			prefix[0]+'_'+na_west[1]+postfix[0],
			prefix[0]+'_'+na_west[2]+postfix[0],
			prefix[0]+'_'+na_west[3]+postfix[0],
			prefix[0]+'_'+na_west[4]+postfix[0],
			prefix[0]+'_'+na_west[5]+postfix[0],
			prefix[0]+'_'+na_west[6]+postfix[0],
			prefix[0]+'_'+na_west[7]+postfix[0],
			prefix[0]+'_'+na_west[8]+postfix[0],
			prefix[0]+'_'+na_west[9]+postfix[0],
			prefix[0]+'_'+na_west[10]+postfix[0],
			prefix[0]+'_'+na_west[11]+postfix[0]]
		end
		
		def na_west_ip
			[na_west[0]+postfix[1],
			na_west[1]+postfix[1],
			na_west[2]+postfix[1],
			na_west[3]+postfix[1],
			na_west[4]+postfix[1],
			na_west[5]+postfix[1],
			na_west[6]+postfix[1],
			na_west[7]+postfix[1],
			na_west[8]+postfix[1],
			na_west[9]+postfix[1],
			na_west[10]+postfix[1],
			na_west[11]+postfix[1]]
		end
		
		def sa
			['aws_south_america']
		end
		
		def south_america_reg
			[prefix[0]+'_'+sa[0]+postfix[0]]
		end
		
		def sa_ip
			[sa[0]+postfix[1]]
		end
		
		def north_america_reg
			north_america_reg_east+north_america_reg_west
		end
		
		def na_all_ip
			na_west_ip+na_east_ip
		end
		
		def all_reg
			apac_reg+europe_reg+north_america_reg+south_america_reg
		end
		
		def all_ip
			apac_ip+europe_ip+na_all_ip+sa_ip
		end
	end
end