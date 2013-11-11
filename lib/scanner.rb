class Scanner
  def self.rate
    "2337" #restriction by the service provider is 4000/second
  end
  def self.rate_cmd
    "--rate " + rate
  end
  def self.masscmd
    "/usr/local/sbin/masscan"
  end
  def self.mass_apac
  	Options.apac_reg.shuffle.each { |a| system(masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
  end
  def self.mass_eu
  	Options.europe_reg.shuffle.each { |a| system(masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
  end
  def self.mass_us_east
  	Options.north_america_reg_east.shuffle.each { |a| system(masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
  end
  def self.mass_us_west
  	Options.north_america_reg_west.shuffle.each { |a| system(masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
  end
  def self.mass_south_america
  	Options.south_america_reg.shuffle.each { |a| system(masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
  end
  def self.mass_us_all
  	Options.north_america_reg.shuffle.each { |a| system(masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
  end
  def self.mass_all
  	Options.all_reg.shuffle.each { |a| system(masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
  end

  def self.nmapcmd
  	"/usr/bin/nmap"
  end
  def self.nmap_options
  	"-sS -P0 -n -O --osscan-limit --version-light --max-rate "+rate+" --randomize-hosts --open --reason"
  end
  def self.nmap_input_file
  	"-iL " + Directories.data_dir
  end
  def self.nmap_flags
  	nmap_options+nmap_input_file
  end
end