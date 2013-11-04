##Brisket - because the data is better when it's cooked low and slow

###About
This repository serves as a collection of frontend scripts to control <a href="https://github.com/robertdavidgraham" target="new">Robert David Graham</a>'s asynchronous TCP port scanner, <a href="https://github.com/robertdavidgraham/masscan" target="new">masscan</a>. From the masscan page:

> It produces results similar to nmap, the most famous port scanner. Internally, it operates 
> more like scanrand, unicornscan, and ZMap, using asynchronous transmission. The major 
> difference is that it's faster than these other scanners. In addition, it's more flexible, 
> allowing arbitrary address ranges and port ranges.

The primary purpose of this application is to scan, store, and prepare Cloud Server Provider (CSP) guest/instance/host data for further statistical and trend analysis.

###Requirements
Each script has different requirements.
####trim.rb
Gems
* require 'rake'
* require 'date'

####rub.rb
Gems
* require 'rake'
* require 'date'

####crutch.rb
Gems
* require 'nokogiri'
* require 'geoip'

####fixins.rb
Gems
require 'open-uri'
require 'zlib'

####turnintime.rb
Gems
* require 'nokogiri'
* require 'geoip'

Data
* The most recent <a href="http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz" target="new">GeoLite City database</a> from MaxMind.

###Usage
####trim.rb
<i>Cooking Note: You must trim the brisket before adding the rub to it.</i>

Used to prepare the scan configuration file with the appropriate set of ports for the scan.

./trim.rb remote|apps|web|db|all

####rub.rb
<i>Cooking Note: Once trimmed, the brisket must be seasoned.</i>

Used to call the masscan scanner and export the results in the appropriate results date directory and file.

./rub.rb apac|europe|us_east|us_west|us_all|south_america|all

####crutch.rb
<i>Cooking Note: Once the brisket is cooked, you put a <a href="http://www.texasmonthly.com/story/importance-wrapping-brisket" target="new">"Texas Crutch"</a> on it to finish it off.</i>

Crutch is used to perform analysis on the collected IP, port, banner, and geolocation data.

./crutch.rb apac|europe|us_east|us_west|south_america|all

####fixins.rb
<i>Cooking Note: It just ain't a BBQ without some proper fixins to make the meal complete.</i>

This script downloads and unpacks the most recent GeoLiteCity database file for use in converting IP addresses to latitude and longitude data.

./trim.rb city

####turnintime.rb
<i>You can't win the competition if you don't turn your meat in on time.</i>

./turnintime.rb <apac|europe|us_east|us_west|south_america|all>

###Contact

To provide any feedback or ask any questions please reach out to Andrew Hay on Twitter at <a href="http://twitter.com/andrewsmhay" target="new">@andrewsmhay</a> or CloudPassage at <a href="http://twitter.com/cloudpassage" target="new">@cloudpassage</a>.

###About CloudPassage
CloudPassage is the leading cloud infrastructure security company and creator of Halo, the industry's first and only security and compliance platform purpose-built for elastic cloud environments. Halo's patented architecture operates seamlessly across any mix of software-defined data center, public cloud, and even hardware infrastructure. Industry-leading enterprises including multiple trust Halo to protect their cloud and software-defined datacenter environments. Headquartered in San Francisco, CA, CloudPassage is backed by Benchmark Capital, Tenaya Capital, Shasta Ventures, and other leading investors. For more information, please visit <a href="http://www.cloudpassage.com" target="new">http://www.cloudpassage.com</a>.

CloudPassage® and Halo® are registered trademarks of CloudPassage, Inc.