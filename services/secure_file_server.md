Secure File Server

		Disable anonymous use or, if anonymous use required, ensure they don't have unauthorized access
		
		If Samba (likely), make sure version is greater than 4.6.4
		Make sure default keys are not used
		Settings found in /etc/samba/smb.conf
		Look at potentially using stunnel https://wiki.netbsd.org/tutorials/how_to_secure_samba_with_stunnel/
