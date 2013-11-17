# == Author
#   Charles Hooper <chooper@plumata.com>
#
# == Copyright
# Copyright (c) 2009, Charles Hooper
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, 
# are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
# list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice, this
# list of conditions and the following disclaimer in the documentation and/or
# other materials provided with the distribution.
#
# * Neither the name of Plumata LLC nor the names of its contributors may be
# used to endorse or promote products derived from this software without specific prior
# written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
# SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
# DAMAGE.
=begin

### How to use >

if ARGV.size < 2
  puts "Usage: ./ip.rb <ip address> <subnet mask>"
  exit(1)
end

ip = IP.new(ARGV[0])
netmask = IP.new(ARGV[1])
info = AddressInfo.new(ip, netmask)

puts "Subnetting information for #{ip}/#{netmask.bits}"
puts "Subnet mask: #{netmask}"
puts "Network Address: #{info.subnet}"
puts "Broadcast: #{info.broadcast}"
puts "Max hosts: #{info.maxhosts}"

=end

class IP
  attr_reader :ip
  
  def initialize(ip)
    # The regex isn't perfect but I like it
    if (ip.to_s() =~ /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/)
      @ip = ip
    else
      # Am certain there is a much more elegant way to do this
      octet = []
      octet[0] = (ip & 0xFF000000) >> 24
      octet[1] = (ip & 0x00FF0000) >> 16
      octet[2] = (ip & 0x0000FF00) >> 8
      octet[3] = ip & 0x000000FF
      @ip = octet.join('.')
    end
  end
  
  def to_i
    # convert ip to 32-bit long (ie: 192.168.0.1 -> 3232235521)    
    ip_split = self.ip.split('.')
    long = ip_split[0].to_i() << 24
    long += ip_split[1].to_i() << 16
    long += ip_split[2].to_i() << 8
    long += ip_split[3].to_i()
    # should return long automagically, yeah?
  end
  
  def to_s
    # This class stores the IP as a string, so we just return it as-is
    @ip
  end

  def bits
    # Count number of bits used (1). This is only really useful for the network mask
    bits = 0
    octets = self.ip.to_s.split('.')
    octets.each { |n|
      bits += Math.log10(n.to_i + 1) / Math.log10(2) unless n.to_i == 0
    }
    bits.to_i
  end
end

class AddressInfo
  attr_reader :ip, :netmask
  
  def initialize(ip, netmask)
    @ip = ip
    @netmask = netmask
  end
  
  def subnet
    # Subnet is calculated by ip AND'd w/ network mask
    @subnet ||= IP.new(ip.to_i & netmask.to_i)
  end
  
  def broadcast
    # Broadcast is calc'd by subnet OR'd w/ inverted network mask
    @broadcast ||= IP.new(self.subnet().to_i | ~@netmask.to_i)
  end

  def maxhosts
    # 2 is subtracted for subnet and broadcast address as they are unusable and not hosts
    @maxhosts ||= self.broadcast.to_i - self.subnet.to_i - 2
  end
end