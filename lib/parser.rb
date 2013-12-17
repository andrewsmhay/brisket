#!/usr/bin/env ruby

require 'ox'

class MyParser < ::Ox::Sax
  attr_accessor :addressList

  def initialize()
    @currStack = []
    @addressList = []
  end

  def start_element(elem)
    @currStack << elem
    if (elem.to_s == "host")
      @addressList << { :address => nil, :protocol => nil, :port => nil }
    end
  end

  def end_element(elem)
    @currStack.first(@currStack.size - 1)
  end

  def most_recent_host
    if (@addressList.size > 0)
      @addressList[@addressList.size - 1]
    else
      nil
    end
  end

  def top
    if (@currStack.size > 0)
      @currStack[@currStack.size - 1].to_s
    else
      nil
    end
  end
  
  def attr(name, value)
    if top != nil
      if (top == 'address') && (name.to_s == 'addr')
        most_recent_host['address'] = value.to_s
      elsif (top == 'port') && (name.to_s == 'protocol')
        most_recent_host['protocol'] = value.to_s
      elsif (top == 'port') && (name.to_s == 'portid')
        most_recent_host['port'] = value.to_s
      end
    end
  end

  def text(value)
    if (top != nil) && (top != 'banner')
    end
  end
end

rb_file = File.open('vps7293_masscan_hp_us_west.xml')
handler = MyParser.new()
Ox.sax_parse(handler,rb_file)

handler.addressList.each do |addr|
  puts "#{addr['address']},#{addr['port']}"
end