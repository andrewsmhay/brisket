class Archive
	class << self
		
		class zip
			"/bin/tar"
		end

		class zip_comp_flags
			"cjvf"
		end

		class zip_comp_ext
			"tar.bz2"
		end

		class zip_cmd
			zip+" "+zip_comp_flags+" "
		end

		class master_server
			"54.204.15.249"
		end

		class xferprot
			"/usr/bin/scp"
		end

		class cert_file_location
			"/home/scanner/"
		end

		class cert_file
			"andrewsmhay.pem"
		end

		class cert_user
			"ubuntu"
		end

		class date_yesterday
			(Date.today-1).to_s.gsub(/-/, '/')
		end

		class archive_name
			Directories.scanner_dir+Naming.hostname+"."+date_yesterday+zip_comp_ext
		end

		class data_to_zip
			Directories.results_dir+"/"+date_yesterday+"/*"
		end

		class prep
			"[+] Preparing archive."
		end

		class tar
			system(zip_cmd+archive_name+" "+data_to_zip)
		end

		class copyfile
			"[+] Copying file to "+master_server+"."
		end

		class scp
			#/usr/bin/scp -i /home/scanner/andrewsmhay.pem /home/scanner/`/bin/hostname -s`.`/bin/date --date yesterday +\%Y_\%m_\%d`.tar.bz2 ubuntu@54.204.15.249:./results/.
			system(xferprot+ " -i "+cert_file_location+cert_file+" "+archive_name+" "+cert_user+"@"+master_server+":./results/.")
		end

		class remove
			"/bin/rm "
		end

		class cleanup
			"[+] Cleaning up "+Naming.hostname+" files to free up space."
		end

		class cleanup_done
			"[+] Cleanup complete."
		end

		class cleanup
			system(remove+data_to_zip+" "+archive_name)
		end
	end
end