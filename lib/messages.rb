class Messages
  def self.trim_opt_sel_err
    "[-] Usage: ./trim.rb <remote|apps|web|db|all> <masscan|nmap|zmap>"
  end
  def self.rub_opt_sel_err
  	"[-] Usage: ./rub.rb <apac|europe|us_east|us_west|us_all|south_america|all> <masscan|nmap|zmap>"
  end
  def self.timenow
    Time.new
  end
  def self.conf_txt
    "[+] Configuration files successfully generated for " +ARGV[0]+ " ports at " +timenow.inspect + "."
  end
  def self.scan_complete 
  	"[+] Scan completed for " + ARGV[0] + " at " + timenow.inspect + "."
  end
  def self.create_dir
  	"[+] The directory" + Directories.results_dir_date + " already exists, no need to create it."
  end
  def self.dir_exists
  	"[+] Created " + Directories.results_dir_date
  end
  def self.scanstart
    "[+] Beginning scan..."
  end
end