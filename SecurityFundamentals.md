As my instructors once said... Be careful who you get help from, cause they could lead you down a very wrong path.

Good luck, young grasshopper.

# Basic Network Security Architecture Implementation

Basic Elements of Security:

* Device Security Features (Admin passwords, SSH, etc)

* Firewalls

* Remote-access VPN

* Intrusion Detection

* Security AAA servers and related AAA services network wide

* Access-control and access-limiting mechanisms on various network devices (ACLs, CAR)

# Security Goals

How to Implement Security:

* What are you protecting?

    1. network equipment-- routers, switches, firewalls

    2. network ops information-- routing tables and ACL configs stored on equipment

    3. intangible network resources-- bandwidth and speed

    4. info and info sources connected to network-- databases

    5. info passing access network

    6. end hosts connecting to network

    7. privacy of users

* What am I protecting it from?

* How likely are the threats?

* Implement measures that protect your assets in a cost-effective manner

* Review and Improve

All Security Should Aim At:

* Confidentiality-- prevent unauthorized access

* Integrity-- prevent unauthorized manipulation/alteration

* Availability-- prevent denial of service

# Securing Principles

1) Minimize attack surface area

    *  only allow ports you use to be talked to

    *  removing services you don't use (to include apps)

    *  who and how can log into SSH

    *  only necessary users

2) Establish secure defaults

    *  no default passwords

3) Principle of Least Privilege

    *  no sudo (no users have root)

    *  access control lists

4) Principle of Defense in depth

    *  make default environments like jails

5) Fail securely

    * what happens in a program when theirs a seg fault (if there's an exception in code)

6) Don't trust services

    *  disable unneeded services

    *  run services under non-privleged user

7) Separation of duties

    *  user accounts only do specific tasks

8) Avoid security by obscurity

    *  don't just make it hard to find things 

9) Keep security simple

10) Fix security issues correctly

    *  updates and patches


