Securing Database Management System

		Use web application firewall
		Encrypt stored files (might not be applicable given competition)
		Enable security Controls
		     - Securing Web Server

		Look into apachetop command tool for monitoring web server
		Make sure SELinux is set to enforcer
		
		If Appache web server, disable trace http request
		make sure it's not running under root user
		Disable signature (hide which version of appache is running)
		Disable Banner
		Use TLS over SSL
		Disable directory listings
		make sure users cannot create own directories
		Examine CGI scripts (how others interact with web server)
		     -Consider CGI Scripts as separate from server and another thing to examine and secure
			i. limit allowable characters
		Upgrade to latest version of appache
