# Networking Tools Notes

# Curl Tool

Challenge:

    Hello, Team!

    This is a test of your curl skillz. You can create an account by POST-ing to "/username" with your password in the form data. Then you can PUT messages there with your password and message. You can also PUT them directly to the home page with your username, password, and message. Have fun!
    Team Messages
    
  What do we do??
  
  Use 'curl'.
  
  First, we must Post username and password:
  
    curl -X POST -d 'password=1337' http://10.15.0.77:5000/z3r0
    
  Then, we must PUT our messages on the website:
  
    curl -X PUT -d 'password=1337' -d 'message:sup' http://10.15.0.77:5000/z3r0
    
  This then adds your information to the page:
  
  
    Hello, Team!

    This is a test of your curl skillz. You can create an account by POST-ing to "/username" with your password in the form data. Then you can PUT messages there with your password and message. You can also PUT them directly to the home page with your username, password, and message. Have fun!
    Team Messages
    
    z3r0:sup
    
  
