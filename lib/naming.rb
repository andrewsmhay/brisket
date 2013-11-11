class Naming
  def self.hostname
    `hostname -s`.chomp
  end
end