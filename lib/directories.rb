class Directories
  class << self
    
    def scanner_dir
      "/home/scanner/"
    end

    def stats
      working_dir+"stats/"
    end

    def working_dir
      scanner_dir+"brisket"
    end

    def conf_dir
      working_dir + "/conf/"
    end
    
    def data_dir
      working_dir + "/data/"
    end
    
    def dir_date
      Date.today.year.to_s+"/"+Date.today.month.to_s+"/"+Date.today.day.to_s+"/"
    end
    
    def results_dir
      working_dir+"/results/"
    end

    def crutch_results_dir
      scanner_dir+"results/"
    end
    
    def results_dir_date
      results_dir + dir_date
    end

    def crutch_results_dir_date
      crutch_results_dir+ARGV[1]+"/"
    end
    
    def results_out
      "-oX " + results_dir_date
    end
    
    def include_file_cmd
      " --includefile " + data_dir
    end
    
    def blacklist
      conf_dir + "exclude.conf"
    end
    
    def exclude_file_cmd
      " --excludefile " + blacklist
    end

    def brisket_log
      "/var/log/brisket.log"
    end
  end
end