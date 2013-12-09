##Brisket - because the data is better when it's cooked low and slow

###About

The primary purpose of this application is to scan, store, and prepare Cloud Server Provider (CSP) guest/instance/host data for further statistical and trend analysis.

###Requirements
Each script has different requirements.

Data
* The most recent <a href="http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz" target="new">GeoLite City database</a> from MaxMind.

###Usage
####trim.rb
<i>Cooking Note: You must trim the brisket before adding the rub to it.</i>

Used to prepare the scan configuration file with the appropriate set of ports for the scan.
<pre><code>
./trim.rb <i>ports</i> masscan

Where <i>ports</i> is one of the following options:
* remote - common remote access server ports
* apps - common application server ports
* www - common web server ports
* mail - common mail ports
* ms - common Microsoft ports
* db - common database ports
* special - special ports for selective scanning
* all - all of the above ports

</code></pre>

The <code>trim.rb</code> command generates the masscan configuration file to be used during the scan.

####rub.rb
<i>Cooking Note: Once trimmed, the brisket must be seasoned.</i>

Used to call the  scanner and export the results in the appropriate results date directory and file.
<p><code>
./rub.rb <i>region</i> <i>scanner</i>

Where <i>region</i> is one of the following options:

apac|europe|us_east|us_west|us_all|south_america|all

and where <i>scanner</i> is one of the following options:
masscan - the masscan scanner
nmap - the nmap scanner
nmap_virtual - the nmap scanner with configurations for virtual interfaces
zmap - the zmap scanner
</code></p>

####fixins.rb
<i>Cooking Note: It just ain't a BBQ without some proper fixins to make the meal complete.</i>

This script downloads and unpacks the most recent GeoLiteCity database file for use in converting IP addresses to latitude and longitude data.

./trim.rb city

####turnintime.rb
<i>You can't win the competition if you don't turn your meat in on time.</i>

Simple script to display the unique IP, port, and banner counts in addition to the types of ports and banners discovered.

./turnintime.rb <apac|europe|us_east|us_west|south_america|all>

###Contact

To provide any feedback or ask any questions please reach out to Andrew Hay on Twitter at <a href="http://twitter.com/andrewsmhay" target="new">@andrewsmhay</a> or CloudPassage at <a href="http://twitter.com/cloudpassage" target="new">@cloudpassage</a>.

###About CloudPassage
CloudPassage is the leading cloud infrastructure security company and creator of Halo, the industry's first and only security and compliance platform purpose-built for elastic cloud environments. Halo's patented architecture operates seamlessly across any mix of software-defined data center, public cloud, and even hardware infrastructure. Industry-leading enterprises including multiple trust Halo to protect their cloud and software-defined datacenter environments. Headquartered in San Francisco, CA, CloudPassage is backed by Benchmark Capital, Tenaya Capital, Shasta Ventures, and other leading investors. For more information, please visit <a href="http://www.cloudpassage.com" target="new">http://www.cloudpassage.com</a>.

CloudPassage® and Halo® are registered trademarks of CloudPassage, Inc.