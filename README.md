##Brisket

###About

The primary purpose of this application is to scan, store, and prepare Cloud Server Provider (CSP) guest/instance/host data for further statistical and trend analysis.
### Description
See the position paper for a sneak peak into what this project was created for.
- <a href="github.com/andrewsmhay/research/blob/master/pp/propertyvalues.md">github.com/andrewsmhay/research/blob/master/pp/propertyvalues.md</a>

###Requirements
Each script has different requirements but you should be able to run <code>bundle install</code> to install the gems listed in the Gemfile.

###Usage
####trim.rb
<i>Cooking Note: You must trim the brisket before adding the rub to it.</i>

Used to prepare the scan configuration file with the appropriate set of ports for the scan.
<pre><code>
	./trim.rb <i>ports</i> masscan

Where <i>ports</i> is one of the following options:
 remote - common remote access server ports
 apps - common application server ports
 www - common web server ports
 mail - common mail ports
 ms - common Microsoft ports
 db - common database ports
 special - special ports for selective scanning
 all - all of the above ports

e.g.
	<b>./trim.rb remote masscan</b>
</code></pre>

####rub.rb
<i>Cooking Note: Once trimmed, the brisket must be seasoned.</i>

Used to call the  scanner and export the results in the appropriate results date directory and file.
<pre><code>
	./rub.rb <i>region</i> <i>scanner</i>
</code></pre>
Where <i>region</i> is one of the following options:
* apac
* europe
* us_east
* us_west
* us_all
* south_america
* all

and where <i>scanner</i> is one of the following options:
* masscan - the masscan scanner
* nmap - the nmap scanner
* nmap_virtual - the nmap scanner with configurations for virtual interfaces
* zmap - the zmap scanner
<pre><code>
e.g.
	<b>./rub.rb apac masscan</b>
</code></pre>

####mop.rb
<i>Keep it moist if you want to win!</i>

Script to convert the various results formats into a common .csv file format.
<pre><code>
	./mop.rb <i>scanner</i> <i>date</i>

Where <i>scanner</i> is one of the following options:
 masscan - the masscan scanner
 nmap - the nmap scanner
 zmap - the zmap scanner

Where <i>date</i> is the date directory that contains the scanner results files to convert in <i>M/D/YYYY</i> format.

e.g. 
	<b>./mop.rb masscan 2/3/2014</b>
</code></pre>

Note - For <i>March 2, 2014</i> the directory structure would be 2014/3/2 and should be entered as 2/3/2014.

####injector.rb
<i>Add marinade to the brisket to keep it moist on the inside...</i>

Script to archive, transfer, and cleanup scan data. All scanner results are archived using <code>tar</code> and <code>bzip2</code>. The daily archive file is transferred to the CloudCooker for futher processing. Local scan results and the daily archive are deleted upon transmission to the CloudCooker.

<pre><code>
	<b>./injector.rb</b>
</code></pre>

####fixins.rb
<i>Cooking Note: It just ain't a BBQ without some proper fixins to make the meal complete.</i>

This script downloads and unpacks the most recent GeoLiteCity database file for use in converting IP addresses to latitude and longitude data.
<pre><code>
	<b>./fixins.rb city</b>
</code></pre>
###Contact

To provide any feedback or ask any questions please reach out to Andrew Hay on Twitter at <a href="http://twitter.com/andrewsmhay" target="new">@andrewsmhay</a> or CloudPassage at <a href="http://twitter.com/cloudpassage" target="new">@cloudpassage</a>.

###About CloudPassage
CloudPassage is the leading cloud infrastructure security company and creator of Halo, the industry's first and only security and compliance platform purpose-built for elastic cloud environments. Halo's patented architecture operates seamlessly across any mix of software-defined data center, public cloud, and even hardware infrastructure. Industry-leading enterprises including multiple trust Halo to protect their cloud and software-defined datacenter environments. Headquartered in San Francisco, CA, CloudPassage is backed by Benchmark Capital, Tenaya Capital, Shasta Ventures, and other leading investors. For more information, please visit <a href="http://www.cloudpassage.com" target="new">http://www.cloudpassage.com</a>.

CloudPassage® and Halo® are registered trademarks of CloudPassage, Inc.