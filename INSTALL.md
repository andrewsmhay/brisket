From your workstation, log into the newly created scanner server:

	$ ssh root@1.2.3.4

On the server, logged in as root, add the 'scanner' user and update the '/etc/sudoers' file:

	# adduser scanner
	# echo "scanner ALL=(ALL:ALL) ALL" >> /etc/sudoers

Configure the log file for brisket and assign ownership to the 'scanner' user:

	# touch /var/log/brisket.log
	# chown scanner:scanner /var/log/brisket.log

Update the package repository and upgrade existing packages:

	# apt-get update > /dev/null
	# apt-get upgrade -y > /dev/null

Install all required packages for masscan, zmap, nmap, and brisket operations:

	# apt-get install libjs-jquery libruby2.0 libyaml-0-2 ruby2.0 ruby2.0-dev rubygems-integration cpp cpp-4.8 gcc gcc-4.8 git git-man libasan0 libatomic1 libc-dev-bin libc6-dev libcloog-isl4 liberror-perl libgcc-4.8-dev libgmp10 libisl10 libitm1 libmpc3 libmpfr4 libpcap-dev libpcap0.8-dev libquadmath0 libtsan0 linux-libc-dev make manpages-dev build-essential byacc dpkg-dev fakeroot flex g++ g++-4.8 gengetopt libalgorithm-diff-perl libalgorithm-diff-xs-perl libalgorithm-merge-perl libdpkg-perl libfile-fcntllock-perl libfl-dev libgmp-dev libgmp3-dev libgmpxx4ldbl libstdc++-4.8-dev m4 libjson0 libjson0-dev cmake cmake-data emacsen-common libarchive13 liblzo2-2 libnettle4 pkg-config libblas3 liblinear-tools liblinear1 liblua5.2-0 nmap > /dev/null

Optionally, but recommended, you can install CloudPassage Halo to protect your scanner:

	# echo 'deb http://packages.cloudpassage.com/debian debian main' | sudo tee /etc/apt/sources.list.d/cloudpassage.list > /dev/null
	# curl http://packages.cloudpassage.com/cloudpassage.packages.key | sudo apt-key add -
	# apt-get -y install cphalo > /dev/null
	# /etc/init.d/cphalod start --daemon-key=$YOURKEY --tag=$YOURGROUP > /dev/null

Back on the workstation, enter the following commands to copy your public key over to the scanner:

	$ ssh-copy-id -i .ssh/scanner.pub scanner@1.2.3.4

Copy your inter-server communication public key (note - in this example it is called andrewsmhay.pem and is located in the Downloads directory):

	$ scp ./Downloads/andrewsmhay.pem scanner@1.2.3.4:.

Log into the server using the 'scanner' account:

	$ ssh scanner@1.2.3.4

On the server, use git to clone the masscan, zmap, and brisket projects:

	$ git clone https://github.com/robertdavidgraham/masscan > /dev/null
	$ git clone https://github.com/zmap/zmap.git > /dev/null
	$ git clone https://github.com/andrewsmhay/brisket.git > /dev/null

Make and configure 'masscan':

	$ cd /home/scanner/masscan
	$ make > /dev/null
	$ sudo cp bin/masscan /usr/local/sbin > /dev/null

Make and configure 'zmap':

	$ cd /home/scanner/zmap/
	$ cmake -DWITH_JSON=ON -DENABLE_HARDENING=ON > /dev/null
	$ make > /dev/null
	$ sudo make install > /dev/null

Install the required ruby gems for 'brisket':

	$ cd /home/scanner/brisket/
	$ sudo gem install bundler > /dev/null
	$ sudo chmod ugo+w /var/lib/gems -R
	$ sudo bundle install > /dev/null

