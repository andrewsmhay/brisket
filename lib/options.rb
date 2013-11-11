class Options
	def self.opt_sel
		['apac','europe','us_east','us_west','south_america','us_all','all']
	end
	def self.prefix
		['masscan','nmap','zmap']
	end
	def self.scan_sel
		prefix
	end
	def self.postfix
		['.conf','.ip','.xml','.json']
	end
	def self.apac_reg
		[prefix[0]+'_softlayer_apac'+postfix[0],
		prefix[0]+'_aws_apac'+postfix[0],
		prefix[0]+'_azure_apac'+postfix[0],
		prefix[0]+'_dimension_data_apac'+postfix[0],
		prefix[0]+'_huawei_apac'+postfix[0]]
	end
	def self.europe_reg
		[prefix[0]+'_tier3_eu_west'+postfix[0],
		prefix[0]+'_softlayer_eu_west'+postfix[0],
		prefix[0]+'_aws_eu'+postfix[0],
		prefix[0]+'_azure_europe_north'+postfix[0],
		prefix[0]+'_azure_europe_west'+postfix[0],
		prefix[0]+'_gogrid_europe_north'+postfix[0],
		prefix[0]+'_joyent_eu'+postfix[0]]
	end
	def self.north_america_reg_east
		[prefix[0]+'_tier3_us_central'+postfix[0],
		prefix[0]+'_tier3_us_east'+postfix[0],
		prefix[0]+'_softlayer_us_central'+postfix[0],
		prefix[0]+'_softlayer_us_east'+postfix[0],
		prefix[0]+'_aws_us_east'+postfix[0],
		prefix[0]+'_azure_us_central'+postfix[0],
		prefix[0]+'_azure_us_east'+postfix[0],
		prefix[0]+'_virtustream_us_east'+postfix[0]]
	end
	def self.north_america_reg_west
		[prefix[0]+'_tier3_us_west'+postfix[0],
		prefix[0]+'_softlayer_us_west'+postfix[0],
		prefix[0]+'_aws_gov_us_west'+postfix[0],
		prefix[0]+'_aws_us_west'+postfix[0],
		prefix[0]+'_azure_us_west'+postfix[0],
		prefix[0]+'_dimension_data_us_west'+postfix[0],
		prefix[0]+'_gogrid_us_west'+postfix[0],
		prefix[0]+'_hp_us_west'+postfix[0],
		prefix[0]+'_rackspace'+postfix[0],
		prefix[0]+'_joyent_us_west'+postfix[0]]
	end
	def self.south_america_reg
		[prefix[0]+'_aws_south_america'+postfix[0]]
	end
	def self.north_america_reg
		north_america_reg_east+north_america_reg_west
	end
	def self.all_reg
		apac_reg+europe_reg+north_america_reg+south_america_reg
	end
end