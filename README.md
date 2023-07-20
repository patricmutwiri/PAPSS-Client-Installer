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


### Make /app/papss and move to it
    sudo mkdir –m777 -p /app/papss
    $ cd /app/papss

### Install Unzip package
    sudo yum -y install unzip

### Install Java Software
    sudo yum -y install java-17-openjdk

### Get PAPSS Artifacts from GitHub
    sudo curl -O -J -L https://github.com/PapssAfrica/PAPSS-Client-Installer/archive/refs/heads/main.zip

### Unzip files
    sudo unzip PAPSS-Client-Installer.zip -d . && sudo rm PAPSS-Client-Installer-main.zip
    sudo mv PAPSS-Client-Installer-main/* . && sudo rm -r PAPSS-Client-Installer-main

### Run PAPSS Installation Script
    cd linux
    sudo chmod u+x papss-linux-installer.sh && ./papss-linux-installer.sh    


### Check status of Systemd Service
sudo systemctl status papssinbound.service
sudo systemctl status papssoutbound.service
sudo systemctl status papssconfig.service


<!-- ### Reset Systemd Service (If need be)

sudo systemctl reset-failed -->


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


