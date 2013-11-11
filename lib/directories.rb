class Directories
  def self.working_dir
    "/home/scanner/brisket"
  end
  def self.conf_dir
    working_dir + "/conf/"
  end
  def self.data_dir
    working_dir + "/data/"
  end
  def self.dir_date
    Date.today.year.to_s+"/"+Date.today.month.to_s+"/"+Date.today.day.to_s+"/"
  end
  def self.results_dir
    working_dir+"/results/"
  end
  def self.results_dir_date
    results_dir + dir_date
  end
  def self.results_out
    "-oX " + results_dir_date
  end
  def self.include_file_cmd
    " --includefile " + data_dir
  end
  def self.exclude_file_cmd
    " --excludefile " + conf_dir + "exclude.conf"
  end
end