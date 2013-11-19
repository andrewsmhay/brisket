#!/usr/bin/env ruby
$LOAD_PATH << '/home/scanner/brisket/lib'
require 'messages'
require 'archive'
require 'naming'
require 'date'
require 'directories'

=begin
/bin/tar cjvf /home/scanner/`hostname -s`.`/bin/date --date yesterday +\%Y_\%m_\%d`.tar.bz2 /home/scanner/brisket/results/`/bin/date --date yesterday +\%Y/\%m/\%d/`*
/usr/bin/scp -i /home/scanner/andrewsmhay.pem /home/scanner/`/bin/hostname -s`.`/bin/date --date yesterday +\%Y_\%m_\%d`.tar.bz2 ubuntu@54.204.15.249:./results/.
/bin/rm /home/scanner/brisket/results/`/bin/date --date yesterday +\%Y/\%m/\%d/`*
/bin/rm /home/scanner/`/bin/hostname -s`.`date --date yesterday +\%Y_\%m_\%d`.tar.bz2
=end

f = File.open(Directories.brisket_log, 'a+')
puts Archive.prep
f.puts Messages.syslog_stamp+Archive.prep

Archive.tar

puts Archive.copyfile
f.puts Messages.syslog_stamp+Archive.copyfile

Archive.scp

puts Archive.cleanup
f.puts Messages.syslog_stamp+Archive.cleanup

Archive.cleanup

puts Archive.cleanup_done
f.puts Messages.syslog_stamp+Archive.cleanup_done
f.close