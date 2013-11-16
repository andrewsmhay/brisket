class Scanner
  class << self
    def rate
      "2337" #restriction by the service provider is 4000/second
    end

    def rate_cmd
      " --rate " + rate
    end

    def masscmd
      "/usr/local/sbin/masscan"
    end

    def mass scans
      scans.shuffle.each do |a|
        system(masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)
      end    
    end



    def nmapcmd
    	"/usr/bin/nmap"
    end
    def nmap_options
    	" -sS -Pn -n --max-rate "+rate+" --open --randomize-hosts --send-eth"
    	#" -sS -P0 -n -O --osscan-limit --version-light --max-rate "+rate+" --randomize-hosts --open --reason"
    end
    def nmap_input_file
    	" -iL " + Directories.data_dir
    end
    def nmap_flags
    	nmap_options+nmap_input_file
    end
    def nmapcmd scans
      scans.shuffle.each do |a|
        system(nmapcmd + " -p " + Ports.remote_ports + nmap_flags + a + Directories.exclude_file_cmd + " " + Directories.results_out + Naming.hostname + "_" + Options.prefix[1] + "_" + a.gsub(/.ip/, '') + Options.postfix[2])}
      end
=begin
    def nmap_apac
    	Options.apac_ip.shuffle.each { |a| system(nmapcmd + " -p " + Ports.remote_ports + nmap_flags + a + Directories.exclude_file_cmd + " " + Directories.results_out + Naming.hostname + "_" + Options.prefix[1] + "_" + a.gsub(/.ip/, '') + Options.postfix[2])}
    end
    def nmap_eu
    	Options.europe_ip.shuffle.each { |a| system(nmapcmd + " -p " + Ports.remote_ports + nmap_flags + a + Directories.exclude_file_cmd + " " + Directories.results_out + Naming.hostname + "_" + Options.prefix[1] + "_" + a.gsub(/.ip/, '') + Options.postfix[2])}
    end
    def nmap_us_east
    	Options.na_east_ip.shuffle.each { |a| system(nmapcmd + " -p " + Ports.remote_ports + nmap_flags + a + Directories.exclude_file_cmd + " " + Directories.results_out + Naming.hostname + "_" + Options.prefix[1] + "_" + a.gsub(/.ip/, '') + Options.postfix[2])}
    end
    def nmap_us_west
    	Options.na_west_ip.shuffle.each { |a| system(nmapcmd + " -p " + Ports.remote_ports + nmap_flags + a + Directories.exclude_file_cmd + " " + Directories.results_out + Naming.hostname + "_" + Options.prefix[1] + "_" + a.gsub(/.ip/, '') + Options.postfix[2])}
    end
    def nmap_south_america
    	Options.sa_ip.shuffle.each { |a| system(nmapcmd + " -p " + Ports.remote_ports + nmap_flags + a + Directories.exclude_file_cmd + " " + Directories.results_out + Naming.hostname + "_" + Options.prefix[1] + "_" + a.gsub(/.ip/, '') + Options.postfix[2])}
    end
    def nmap_us_all
    	Options.na_all_ip.shuffle.each { |a| system(nmapcmd + " -p " + Ports.remote_ports + nmap_flags + a + Directories.exclude_file_cmd + " " + Directories.results_out + Naming.hostname + "_" + Options.prefix[1] + "_" + a.gsub(/.ip/, '') + Options.postfix[2])}
    end
    def nmap_all
    	Options.all_ip.shuffle.each { |a| system(nmapcmd + " -p " + Ports.remote_ports + nmap_flags + a + Directories.exclude_file_cmd + " " + Directories.results_out + Naming.hostname + "_" + Options.prefix[1] + "_" + a.gsub(/.ip/, '') + Options.postfix[2])}
    end
=end

    def zmapcmd
      "/usr/local/sbin/zmap"
    end
    def zmap_seed
      " -e 1337"
    end
    def zmap scans
      scans.shuffle.each do |a|
        Ports.all_ports_ary.each do |b|
          system(zmapcmd + " -p " + b + zmap_seed + rate_cmd + " -w " + a + " -b " + Directories.blacklist + " -O json " + "-o " + Directories.results_dir_date + Naming.hostname + "_" + Options.prefix[2] + "_" + a.gsub(/.conf/, '') + Options.postfix[3])}
        end
      end    
    end
=begin
    def zmap_apac
      Options.apac_reg.shuffle.each { |a| system(zmapcmd + " -p " + Ports.remote_ports + zmap_seed + rate_cmd + " -w " + a + " -b " + Directories.blacklist + " -O json " + "-o " + Directories.results_dir_date + Naming.hostname + "_" + Options.prefix[2] + "_" + a.gsub(/.conf/, '') + Options.postfix[3])}
    end
    def zmap_eu
      Options.europe_reg.shuffle.each { |a| system(zmapcmd + " -p " + Ports.remote_ports + zmap_seed + rate_cmd + " -w " + a + " -b " + Directories.blacklist + " -O json " + "-o " + Directories.results_dir_date + Naming.hostname + "_" + Options.prefix[2] + "_" + a.gsub(/.conf/, '') + Options.postfix[3])}
    end
    def zmap_us_east
      Options.north_america_reg_east.shuffle.each { |a| system(zmapcmd + " -p " + Ports.remote_ports + zmap_seed + rate_cmd + " -w " + a + " -b " + Directories.blacklist + " -O json " + "-o " + Directories.results_dir_date + Naming.hostname + "_" + Options.prefix[2] + "_" + a.gsub(/.conf/, '') + Options.postfix[3])}
    end
    def zmap_us_west
      Options.north_america_reg_west.shuffle.each { |a| system(zmapcmd + " -p " + Ports.remote_ports + zmap_seed + rate_cmd + " -w " + a + " -b " + Directories.blacklist + " -O json " + "-o " + Directories.results_dir_date + Naming.hostname + "_" + Options.prefix[2] + "_" + a.gsub(/.conf/, '') + Options.postfix[3])}
    end
    def zmap_south_america
      Options.south_america_reg.shuffle.shuffle.each { |a| system(zmapcmd + " -p " + Ports.remote_ports + zmap_seed + rate_cmd + " -w " + a + " -b " + Directories.blacklist + " -O json " + "-o " + Directories.results_dir_date + Naming.hostname + "_" + Options.prefix[2] + "_" + a.gsub(/.conf/, '') + Options.postfix[3])}
    end
    def zmap_us_all
      Options.north_america_reg.shuffle.each { |a| system(zmapcmd + " -p " + Ports.remote_ports + zmap_seed + rate_cmd + " -w " + a + " -b " + Directories.blacklist + " -O json " + "-o " + Directories.results_dir_date + Naming.hostname + "_" + Options.prefix[2] + "_" + a.gsub(/.conf/, '') + Options.postfix[3])}
    end
    def zmap_all
      Options.all_reg.shuffle.shuffle.each { |a| system(zmapcmd + " -p " + Ports.remote_ports + zmap_seed + rate_cmd + " -w " + a + " -b " + Directories.blacklist + " -O json " + "-o " + Directories.results_dir_date + Naming.hostname + "_" + Options.prefix[2] + "_" + a.gsub(/.conf/, '') + Options.postfix[3])}
    end
=end
  end
end
