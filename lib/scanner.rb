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