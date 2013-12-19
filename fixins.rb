#!/usr/bin/env ruby
$LOAD_PATH << '/home/scanner/brisket/lib'
require 'open-uri'
require 'zlib'

working_dir = "/home/scanner/brisket"
geo_dat_city = "http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz"
opt_sel = ['city']
opt_sel_err = "[-] Usage: ./fixins.rb city"

commands = []
ARGV.each {|arg| commands << arg}
if ARGV[0] == opt_sel[0]
open('GeoLiteCity.dat.gz', 'w') do |local_file|
  open(geo_dat_city) do |remote_file|
    local_file.write(Zlib::GzipReader.new(remote_file).read)
  end
end
File.rename("GeoLiteCity.dat.gz", "GeoLiteCity.dat")
puts "[+] GeoLiteCity database downloaded..."
else puts opt_sel_err
end