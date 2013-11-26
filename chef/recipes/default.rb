#
# Cookbook Name:: brisket
# Recipe:: default
#
# Copyright 2013, CloudPassage 
#
# All rights reserved - Do Not Redistribute
#
user "scanner" do  
  home "/home/scanner"
  uid 1234
  gid 0
  comment "Scanner"
  shell "/bin/bash"
  supports :manage_home => true
  action :create
end

group "scanner" do
  group_name = "scanner"
  action :create
end

directory "/home/scanner" do 
  owner "scanner"
  group "scanner"
  mode 644
  action :create
end

bash "append_to_sudoers" do
  user "root"
  code <<-EOF
    echo "scanner ALL=(ALL:ALL) ALL" >> /etc/sudoers
  EOF
end

file "/var/log/brisket.log" do
  action :touch
end

directory "/var/log/brisket.log" do
  owner "scanner"
  group "scanner"
  action :create
end

execute "apt-get update" do
  command "apt-get update" 
  action :run
end

execute "apt-get upgrade -y" do
  command "apt-get upgrade -y" 
  action :run
end
 
apt_package "libjs-jquery" do 
  action :install
end

apt_package "libruby2.0" do 
  action :install
end

apt_package "libyaml-0-2" do 
  action :install
end

apt_package "ruby2.0" do
  action :install
end

apt_package "ruby2.0-dev" do 
  action :install
end

apt_package "rubygems-integration" do 
  action :install
end

apt_package "cpp" do
  action :install
end

apt_package "cpp-4.8" do
  action :install
end

apt_package "gcc" do
  action :install
end

apt_package "gcc-4.8" do
  action :install
end

apt_package "git" do 
  action :install
end

apt_package "git-man" do
  action :install
end

apt_package "libasan0" do 
  action :install
end

apt_package "libatomic1" do 
  action :install
end

apt_package "libc-dev-bin" do 
  action :install
end

apt_package "libc6-dev" do 
  action :install
end

apt_package "libcloog-isl4" do 
  action :install
end

apt_package "liberror-perl" do
   action :install
end

apt_package "libgcc-4.8-dev" do 
  action :install
end

apt_package "libgmp10" do 
  action :install
end

apt_package "libisl10" do 
  action :install
end

apt_package "libitm1" do 
  action :install
end

apt_package "libmpc3" do 
  action :install
end

apt_package "libmpfr4" do 
  action :install
end

apt_package "libpcap-dev" do 
  action :install
end

apt_package "libpcap0.8-dev" do 
  action :install
end

apt_package "libquadmath0 " do  
  action :install
end

apt_package "libtsan0" do 
  action :install
end

apt_package "linux-libc-dev" do 
  action :install
end

apt_package "make" do 
  action :install
end

apt_package "manpages-dev" do 
  action :install
end

apt_package "build-essential" do 
  action :install
end

apt_package "byacc" do 
  action :install
end

apt_package "dpkg-dev" do 
  action :install
end

apt_package "fakeroot" do 
  action :install
end

apt_package "flex" do 
  action :install
end

apt_package "g++" do 
  action :install
end

apt_package "g++-4.8" do 
  action :install
end

apt_package "gengetopt" do 
  action :install
end

apt_package "libalgorithm-diff-perl" do 
  action :install
end

apt_package "libalgorithm-diff-xs-perl" do 
  action :install
end

apt_package "libalgorithm-merge-perl" do 
  action :install
end

apt_package "libdpkg-perl" do 
  action :install
end

apt_package "libfile-fcntllock-perl" do 
  action :install
end

apt_package "libfl-dev" do 
  action :install
end

apt_package"libgmp-dev" do 
  action :install
end

apt_package "libgmp3-dev" do
  action :install
end

apt_package "libgmpxx4ldbl" do 
  action :install
end

apt_package "libstdc++-4.8-dev" do 
  action :install
end

apt_package "m4" do 
  action :install
end

apt_package "libjson0" do 
  action :install
end

apt_package "libjson0-dev" do 
  action :install
end

apt_package "cmake" do 
  action :install
end

apt_package "cmake-data" do
  action :install
end

apt_package "emacsen-common" do 
  action :install
end

apt_package "libarchive13" do 
  action :install
end

apt_package "liblzo2-2" do 
  action :install
end

apt_package "libnettle4" do 
  action :install
end

apt_package "liblzo2-2" do 
  action :install
end

apt_package "pkg-config" do 
  action :install
end

apt_package "libblas3" do 
  action :install
end

apt_package "liblinear-tools" do 
  action :install
end

apt_package "liblinear1" do 
  action :install
end

apt_package "liblua5.2-0" do 
  action :install
end

apt_package "nmap" do 
  action :install
end

execute "Git Clone masscan" do
  installation_dir = "/home/scanner"
  cwd installation_dir
  command "git clone https://github.com/robertdavidgraham/masscan"
  action :run
  not_if {File.exists?("/home/scanner/masscan")}
end

execute "Git Clone zmap" do
  installation_dir = "/home/scanner"
  cwd installation_dir
  command "git clone https://github.com/zmap/zmap.git"
  action :run
  not_if {File.exists?("/home/scanner/zmap")}
end

execute "Git Clone brisket" do
  installation_dir = "/home/scanner"
  cwd installation_dir
  command "git clone https://github.com/andrewsmhay/brisket.git"
  action :run
  not_if {File.exists?("/home/scanner/brisket")}
end

execute "Make and configure masscan" do
  configuration_dir = "/home/scanner/masscan"
  cwd configuration_dir
  command "make"
  action :run
end

execute "Copy masscan to local bin" do
  configuration_dir = "/home/scanner/masscan"
  cwd configuration_dir
  command "sudo cp bin/masscan /usr/local/sbin"
  action :run
end

execute "Make and configure zmap" do
  configuration_dir = "/home/scanner/zmap"
  cwd configuration_dir
  command "cmake -DWITH_JSON=ON -DENABLE_HARDENING=ON"
  action :run
end

execute "Make zmap" do
  configuration_dir = "/home/scanner/zmap"
  cwd configuration_dir
  command "make"
  action :run
end

execute "Install zmap" do
  configuration_dir = "/home/scanner/zmap"
  cwd configuration_dir
  command "make install"
  action :run
end
  
execute "Install the required ruby gems for brisket" do
  configuration_dir = "/home/scanner/brisket"
  cwd configuration_dir
  command "sudo gem install bundler"
  action :run
end

execute "Chmod gems" do 
  command "sudo chmod ugo+w /var/lib/gems -R"
  action :run
end

execute "bundle install" do
  configuration_dir = "/home/scanner/brisket"
  cwd configuration_dir
  command "sudo bundle install"
  action :run
end
