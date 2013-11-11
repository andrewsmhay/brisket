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
  	Options.reg[0].each { |a| system(masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
  end
  def self.mass_eu
  	Options.reg[1].each { |a| system(masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
  end
  def self.mass_us_east
  	Options.reg[2].each { |a| system(masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
  end
  def self.mass_us_west
  	Options.reg[3].each { |a| system(masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
  end
  def self.mass_south_america
  	Options.reg[4].each { |a| system(masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
  end
  def self.mass_us_all
  	Options.reg[5].each { |a| system(masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
  end
  def self.mass_all
  	Options.reg[6].each { |a| system(masscmd + " -c " + Directories.conf_dir + a + " --banners" + Directories.exclude_file_cmd)}
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