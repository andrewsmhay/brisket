class Ports
  class << self
    def remote_ports_ary
      ['22','23','513','3389','5900']
    def remote_ports
      "22,23,513,3389,5900"
    end
    def app_ports_ary
      ['21','69','53','389','161','1984']
    end
    def app_ports
      "21,69,53,389,161,1984"
    end
    def ms_ports_ary
      ['135','137','138','139','389','445']
    end
    def ms_ports
      "135,137,138,139,389,445"
    end
    def mail_ports_ary
      ['25','110','995','993','465']
    end
    def mail_ports
      "25,110,995,993,465"
    end
    def web_ports_ary
      ['80','443','8080','8443','8888']
    end
    def web_ports
      "80,443,8080,8443,8888"
    end
    def db_ports_ary
      ['1433','1521','3306','5432']
    end
    def db_ports
      "1433,1521,3306,5432"
    end
    def special_ports_ary
      ['6667','9050','1514','20000']
    end
    def special_ports
      # IRC, tor, tcp syslog, DNP3 (SCADA networks)
      "6667,9050,1514,20000"
    end
    def all_ports_ary
      remote_ports_ary+app_ports_ary+web_ports_ary+db_ports_ary+special_ports_ary+ms_ports_ary+mail_ports_ary
    end
    def all_ports
      remote_ports + "," + app_ports + "," + web_ports + "," + db_ports + "," + special_ports + "," + ms_ports + "," + mail_ports
    end
  end
end