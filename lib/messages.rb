class Messages
  class << self
    def trim_opt_sel_err
      "[-] Usage: ./trim.rb <remote|apps|web|db|all> <masscan|nmap|zmap>"
    end

    def rub_opt_sel_err
    	"[-] Usage: ./rub.rb <apac|europe|us_east|us_west|us_all|south_america|all> <masscan|nmap|zmap>"
    end

    def crutch_opt_sel_err
      "[-] Usage: ./crutch.rb <apac|europe|us_east|us_west|south_america|all> <yyyy/mm/dd>"
    end
    
    def timenow
      Time.new
    end
    
    def conf_txt
      "[+] Configuration files successfully generated for " +ARGV[0]+ " ports at " +timenow.inspect + "."
    end

    def conf_sys_txt
      syslog_stamp+conf_txt
    end

    def conf_dir_txt
      "[+] Configuration files stored in " + Directories.conf_dir + "."
    end

    def conf_sys_dir
      syslog_stamp+conf_dir_txt
    end
    
    def scan_complete 
    	"[+] Scan of " + ARGV[1] + " ports completed for " + ARGV[0] + " at " + timenow.inspect + "."
    end
    
    def create_dir
    	"[+] The directory" + Directories.results_dir_date + " already exists."
    end
    
    def dir_exists
    	"[+] Created " + Directories.results_dir_date
    end

    def dir_sys_create
      syslog_stamp+"[+] Created " + Directories.results_dir_date
    end
    
    def scanstart
      "[+] Beginning " + ARGV[1] + " scan for " + ARGV[0] + "..."
    end
    
    def tbd
      "This code has not yet been written..."
    end

    def syslog_stamp
      `date "+%b %d %H:%I:%M"`.chomp + " " + `hostname`.chomp + " "
    end
    
    def dir_sys_exist
      syslog_stamp+"[+] The directory" + Directories.results_dir_date + " already exists, no need to create it."  
    end

    def res_written
      syslog_stamp+"[+] Results file written to " + Directories.results_dir_date
    end

    def scan_sys_comp
      syslog_stamp+scan_complete
    end

    def converted
      "[+] Analysis and conversion of " + ARGV[0] + " completed at " + timenow.inspect + "."
    end

    def ssh_to_bnode
      "[+] Connecting to "
    end

    def update_git
      "[+] Updating all brisket nodes..."
    end

    def git_pull
      "[+] Pulling from brisket git repo..."
    end

    def free_space
      "[+] Showing free space on the filesystem..."
    end

    def log_file
      "[+] Displaying the last 10 brisket.log entries..."
    end

    def proc_listing
      "[+] Checking to see if rub.rb is running..."
    end
  end
end