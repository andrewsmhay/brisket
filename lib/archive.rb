class Archive
	class << self
		
		def zip
			"/bin/tar"
		end

		def zip_comp_flags
			"cjvf"
		end

		def zip_comp_ext
			".tar.bz2"
		end

		def zip_cmd
			zip+" "+zip_comp_flags+" "
		end

		def master_server
			"54.204.15.249"
		end

		def xferprot
			"/usr/bin/scp"
		end

		def cert_file_location
			"/home/scanner/"
		end

		def cert_file
			"andrewsmhay.pem"
		end

		def cert_user
			"ubuntu"
		end

		def date_yesterday
			(Date.today-1)
		end

		def date_yesterday_dir
			date_yesterday.to_s.gsub(/-/, '/')
		end

		def date_yesterday_filename
			date_yesterday.to_s.gsub(/-/, '\_')
		end

		def archive_name
			Directories.scanner_dir+Naming.hostname+"_"+date_yesterday_filename+zip_comp_ext
		end

		def data_to_zip
			Directories.results_dir+date_yesterday_dir+"/*"
		end

		def prep
			"[+] Preparing archive."
		end

		def tar
			system(zip_cmd+archive_name+" "+data_to_zip)
		end

		def copyfile
			"[+] Copying file to "+master_server+"."
		end

		def scp
			#/usr/bin/scp -i /home/scanner/andrewsmhay.pem /home/scanner/`/bin/hostname -s`.`/bin/date --date yesterday +\%Y_\%m_\%d`.tar.bz2 ubuntu@54.204.15.249:./results/.
			system(xferprot+ " -i "+cert_file_location+cert_file+" "+archive_name+" "+cert_user+"@"+master_server+":./results/.")
		end

		def remove
			"/bin/rm "
		end

		def cleanup
			"[+] Cleaning up "+Naming.hostname+" files to free up space."
		end

		def cleanup_done
			"[+] Cleanup complete."
		end

		def cleanup
			system(remove+data_to_zip+" "+archive_name)
		end
	end
end