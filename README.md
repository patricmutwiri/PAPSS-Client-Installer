# PAPSS-Middleware-Installer

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

### Install Unzip package
    sudo yum -y install unzip

### Install Java Software
    sudo yum -y install java-17-openjdk

### Create PAPSS Middleware directory and cd to it
    sudo mkdir –m777 -p /var/papss
    cd /var/papss



### Get PAPSS Artifacts from GitHub
    sudo curl -O -J -L https://github.com/PapssAfrica/PAPSS-Client-Installer/archive/refs/heads/main.zip

### Unzip files
    sudo unzip PAPSS-Client-Installer-main.zip -d . && sudo rm PAPSS-Client-Installer-main.zip
    sudo mv PAPSS-Client-Installer-main/* . && sudo rm -r PAPSS-Client-Installer-main

### Run PAPSS Installation Script
    sudo chmod u+x linux/papss-linux-installer.sh && ./linux/papss-linux-installer.sh  

### Installing PAPSS Configuration Service as a systemd Service
With the PAPSS-Configuration-Service-1.0.jar Spring Boot application installed in /var/papss/lib, to install it as a systemd service, create a script named papssconfig.service and place it in /etc/systemd/system directory.

    vi /etc/systemd/system/papssconfig.service

Copy and past the following to the `vi` terminal :

    [Unit]
    Description=PAPSS Configuration Service
    After=syslog.target
    
    [Service]
    User=papss
    Type=simple
    Restart=on-failure
    RestartSec=10
    WorkingDirectory=/var/papss/lib
    ExecStart=/bin/java -Xms2048m -Xmx4096m -jar PAPSS-Configuration-Service-1.0.jar
    SuccessExitStatus=143
    
    [Install]
    WantedBy=multi-user.target

Enable the papssconfig.service
    systemctl enable papssconfig.service
Start the papssconfig.service
    systemctl start papssconfig.service
Check status of the papssconfig.service
    systemctl status papssconfig.service

#### Validate Configuration Service is running
    curl -u root:s3cr3t --request GET http://localhost:8888/papss-outbound-iso-service/native

### Installing PAPSS Outbound ISO Service as a systemd Service
With the PAPSS-Outbound-ISO-Service-1.0.jar Spring Boot application installed in /var/papss/lib, to install it as a systemd service, create a script named papssoutbound.service and place it in /etc/systemd/system directory.

    vi /etc/systemd/system/papssoutbound.service

Copy and past the following to the `vi` terminal :

    [Unit]
    Description=PAPSS Outbound ISO Service
    After=syslog.target
    
    [Service]
    User=papss
    Type=simple
    Restart=on-failure
    RestartSec=10
    WorkingDirectory=/var/papss/lib
    ExecStart=/bin/java -Xms2048m -Xmx4096m -jar PAPSS-Outbound-ISO-Service-1.0.jar
    SuccessExitStatus=143
    
    [Install]
    WantedBy=multi-user.target
    
Enable the papssoutbound.service
    systemctl enable papssoutbound.service
Start the papssoutbound.service
    systemctl start papssoutbound.service
Check status of the papssoutbound.service
    systemctl status papssoutbound.service

#### Validate PAPSS Outbound ISO Service is running
    curl --location 'http://localhost:8881/papss/api/participantlist' \
    --header 'Content-Type: application/json' \
    --data '{
        "sender": {
            "inst_id":"NG2020"
        },
        "inst_id":"NG2020",
        "participant_type" : "BANK",
        "isOnline" : true
    }'

### Installing PAPSS Inbound ISO Service as a systemd Service
With the PAPSS-Inbound-ISO-Service-1.0.jar Spring Boot application installed in /var/papss/lib, to install it as a systemd service, create a script named papssinbound.service and place it in /etc/systemd/system directory.

    vi /etc/systemd/system/papssinbound.service

Copy and past the following to the `vi` terminal :

    [Unit]
    Description=PAPSS Inbound ISO Service
    After=syslog.target
    
    [Service]
    User=papss
    Type=simple
    Restart=on-failure
    RestartSec=10
    WorkingDirectory=/var/papss/lib
    ExecStart=/bin/java -Xms2048m -Xmx4096m -jar PAPSS-Inbound-ISO-Service-1.0.jar
    SuccessExitStatus=143
    
    [Install]
    WantedBy=multi-user.target
    
Enable the papssinbound.service 
    systemctl enable papssinbound.service 
Start the papssinbound.service 
    systemctl start papssinbound.service 
Check status of the papssinbound.service 
    systemctl status papssinbound.service

#### Validate PAPSS Inbound ISO Service is running
    curl --location 'http://localhost:8881/papss/api/participantlist' \
    --header 'Content-Type: application/json' \
    --data '{
        "sender": {
            "inst_id":"NG2020"
        },
        "inst_id":"NG2020",
        "participant_type" : "BANK",
        "isOnline" : true
    }'

### Systemd Service Debug Commands
Reset failed:
    systemctl reset-failed
Reload Daemon:
    systemctl daemon-reload


## Windows Server 2019 Installation

### Install Java Open JDK 17
Installing OpenJDK with the MSI installer
This procedure describes how to install OpenJDK 20 for Windows using the MSI-based installer.

#### Procedure

Download the MSI-based installer of OpenJDK 20 for Windows. https://adoptium.net/download/
Run the installer for OpenJDK 20 for Windows.
Click Next on the welcome screen.
Check I accept the terms in license agreement, then click Next.
Click Next.
Accept the defaults or review the optional properties.
Click Install.
Click Yes on the Do you want to allow this app to make changes on your device?.
Verify the OpenJDK 20 for Windows is successfully installed, run java -version command in the command prompt and you must get the following output:

```openjdk version "17" 2021-09-14 LTS
OpenJDK Runtime Environment 21.9 (build 17+35-LTS)
OpenJDK 64-Bit Server VM 21.9 (build 17+35-LTS, mixed mode, sharing)
``` 
#### Tutorial https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-do-I-install-Java-on-Windows

### Download and Install Postgres 14

https://www.postgresql.org/download/windows/

Password for default postgres user s3cr3t


