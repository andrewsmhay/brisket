class Ports
  def self.remote_ports
    "22,23,513,3389,5900"
  end
  def self.app_ports
    "21,69,53,389,161,1984"
  end
  def self.ms_ports
    "135,137,138,139,389,445"
  end
  def self.mail_ports
    "25,110,995,993,465"
  end
  def self.web_ports
    "80,443,8080,8443,8888"
  end
  def self.db_ports
    "1433,1521,3306,5432"
  end
  def self.special_ports
    # IRC, tor, tcp syslog, DNP3 (SCADA networks)
    "6667,9050,1514,20000"
  end
  def self.all_ports
    remote_ports + "," + app_ports + "," + web_ports + "," + db_ports + "," + special_ports + "," + ms_ports + "," + mail_ports
  end
end