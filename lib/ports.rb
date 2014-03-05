class Ports
  class << self
    def remote_ports_ary
      ['22',      # ssh
        '23',     # telnet
        '513',    # rlogin
        '3389',   # rdp
        '5900']   # vnc
    end

    def remote_ports
      "22,23,513,3389,5900"
    end

    def app_ports_ary
      ['21',      # ftp
        '69',     # TFTP
        '161',    # SNMP
        '443']    # https
    end

    def app_ports
      "21,69,161,443"
    end

    def ms_ports_ary
      ['135',     # DCE/RPC Locator service / DCOM
        '137',    # NetBIOS NetBIOS Name Service
        '138',    # NetBIOS NetBIOS Datagram Service
        '139',    # NetBIOS NetBIOS Session Service
        '389',    # LDAP
        '445']    # Microsoft-DS Active Directory, Windows shares
    end

    def ms_ports
      "135,137,138,139,389,445"
    end

    def mail_ports_ary
      ['25',      # smtp
        '110',    # pop3
        '143',    # imap
        '995',    # ssl pop3
        '993',    # ssl imap
        '465']    # ssl smtp
    end

    def mail_ports
      "25,110,143,995,993,465"
    end

    def web_ports_ary
      ['80',      # http
        '902',    # SOCKS
        '3128',   # squid
        '9462',   # Chef server WebUI
        '8080',   # http alternate
        '8443',   # https alternate
        '8888']   # http alternate
    end

    def web_ports
      "80,8080,8443,8888,3128,902,9462"
    end

    def db_ports_ary
      ['1433',    # MS SQL
        '1434',   # MS SQL
        '1521',   # Oracle
        '3306',   # MySQL
        '5432',   # postgresql
        '6379',   # redis
        '5984']   # couchdb
    end

    def db_ports
      "1433,1434,1521,3306,5432,6379,5984"
    end

    def special_ports_ary
      ['6667',    # IRC
        '9050',   # tor
        '1514',   # tcp syslog
        '1984',   # rackspace agent
        '4000',   # Chef server knife access
        '8140',   # puppet
        '8081',   # Arrayent SDK port - https://sites.google.com/a/arrayent.com/api/
        '61613']  # puppet orchestration
    end

    def special_ports
      "6667,9050,1514,1984,8140,61613,4000,8081"
    end

    def all_ports_ary
      remote_ports_ary+app_ports_ary+web_ports_ary+db_ports_ary+special_ports_ary+ms_ports_ary+mail_ports_ary
    end

    def all_ports
      remote_ports + "," + app_ports + "," + web_ports + "," + db_ports + "," + special_ports + "," + ms_ports + "," + mail_ports
    end
  end
end
