# PAPSS-Installer

## Redhat Linux Installation

### Run following commands


### Install the PostgreSQL Software

    Open the distribution .repo file in vi:

    sudo vi /etc/yum.repos.d/CentOS-Base.repo

    Exclude PostgreSQL by appending the following line to both the [base] and [updates] sections:

    exclude=postgresql*

    Download and install the PGDG file from postgresql.org:

    sudo yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

    Install PostgreSQL 12:

    sudo yum install -y postgresql12-server postgresql12-contrib


### Initialize the Database

    Initialize the database:

    sudo /usr/pgsql-12/bin/postgresql-12-setup initdb

    Start and enable the postgresql-12 service:

    sudo systemctl start postgresql-12
    sudo systemctl enable postgresql-12


[//]: # (### Connect as the Default User)

[//]: # ()
[//]: # (    Change to the postgres user and launch psql:)

[//]: # ()
[//]: # (    sudo su - postgres)

[//]: # (    $ psql)


### Make /app/papss and move to it
    sudo mkdir –m777 -p /app/papss
    $ cd /app/papss

### Install Unzip package
    sudo yum -y install unzip

### Install Java Software
    sudo yum -y install java-17-openjdk

### Get PAPSS Artifacts from GitHub
    sudo curl -O -J -L https://github.com/PapssAfrica/PAPSS-Installer/archive/refs/heads/main.zip

### Unzip files
    sudo unzip PAPSS-Installer-main.zip -d . && sudo rm PAPSS-Installer-main.zip
    sudo mv PAPSS-Installer-main/* . && sudo rm -r PAPSS-Installer-main

### Run PAPSS Installation Script
    sudo chmod u+x papss-linux-installer.sh && ./papss-linux-installer.sh



    
6. sudo unzip PAPSS-Installer-main.zip -d . && sudo rm PAPSS-Installer-main.zip
7. sudo mv PAPSS-Installer-main/* . && sudo rm -r PAPSS-Installer-main
8. sudo groupadd -r papss
9. sudo useradd -r -s /bin/false -g papss papss
10. id papss
11. sudo mv papss-inbound-iso.service /etc/systemd/system/ && sudo chmod 0644 /etc/systemd/system/papss-inbound-iso.service
12. sudo mv papss-outbound-iso.service /etc/systemd/system/ && sudo chmod 0644 /etc/systemd/system/papss-outbound-iso.service
13. sudo chown -R papss:papss /app/papss
14. sudo systemctl daemon-reload
15. java -version
16. sudo systemctl start papssoutbound.service
17. sudo systemctl start papssinbound.service
18. sudo systemctl status papssinbound.service
19. sudo systemctl status papssoutbound.service

20. sudo chmod 500 jar-files/PAPSS-Inbound-ISO-Service-1.0.jar
21. sudo mv papss-inbound-iso.service /etc/systemd/system/ && sudo chmod 0644 /etc/systemd/system/papss-inbound-iso.service
22. sudo mv papss-outbound-iso.service /etc/systemd/system/ && sudo chmod 0644 /etc/systemd/system/papss-outbound-iso.service
23. sudo systemctl start papss-inbound-iso.service
24. sudo systemctl start papss-outbound-iso.service


12. 
13. /bin/bash unzip "$(curl -fsSL https://github.com/PapssAfrica/PAPSS-Installer/archive/refs/heads/main.zip)" -d .
14. sudo rm PAPSS-Installer-main.zip && rmdir PAPSS-Installer-main

-rw-r--r--.
