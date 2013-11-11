class Masscan
  def self.rate
    "2337" #restriction by the service provider is 4000/second
  end
  def self.rate_cmd
    "--rate " + rate
  end
  def self.cmd
    "/usr/local/sbin/masscan"
  end
end