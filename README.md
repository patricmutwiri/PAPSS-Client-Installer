# PAPSS-Middleware-Installer

## Redhat Linux Installation

### Run following commands

### Install Unzip package
    sudo yum -y install unzip

### Install Java Software
    sudo yum -y install java-17-openjdk

### Create PAPSS Middleware directory and cd to it
    sudo mkdir –m777 -p /var/papss
    cd /var/papss

### Setup PAPSS_HOME
    vi /etc/profile

Add the following environment variable

    export PAPSS_HOME=/var/papss

Confirm changesor the changes to take effect, use the command 

    env

### Get PAPSS Artifacts from GitHub
    sudo curl -O -J -L https://github.com/PapssAfrica/PAPSS-Client-Installer/archive/refs/heads/main.zip

### Unzip files and move to the PAPSS_HOME directory

    sudo unzip PAPSS-Client-Installer-main.zip -d /var/papss/
    
    sudo rm PAPSS-Client-Installer-main.zip    
    
    sudo rm -r PAPSS-Client-Installer-main

### Give PAPSS Installation Script execute permissions

    sudo chmod u+x linux/papss-linux-installer.sh 

### Run PAPSS Installation Script
    
    sh /linux/papss-linux-installer.sh  

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
    ExecStart=/bin/java -Xms1024m -Xmx2048m -jar PAPSS-Configuration-Service-1.0.jar --spring.cloud.config.server.native.search-locations=file:///var/papss/config
    SuccessExitStatus=143
    
    [Install]
    WantedBy=multi-user.target

Give /etc/systemd/system/papssconfig.service permissions

    chmod 777 /etc/systemd/system/papssconfig.service

Enable the papssconfig.service

    systemctl enable papssconfig.service

Reload Daemon:

    systemctl daemon-reload
    
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
    ExecStart=/bin/java -Dcom.montran.config.dir=/var/papss/config -Dorg.sqlite.tmpdir=/var/papss/db/sqlite/tmp -Xms1024m -Xmx2048m -jar PAPSS-Outbound-ISO-Service-1.0.jar
    SuccessExitStatus=143
    
    [Install]
    WantedBy=multi-user.target
    
Give /etc/systemd/system/papssoutbound.service permissions

    chmod 777 /etc/systemd/system/papssoutbound.service

Enable the papssoutbound.service

    systemctl enable papssoutbound.service

Reload Daemon:

    systemctl daemon-reload
    
Start the papssoutbound.service

    systemctl start papssoutbound.service
    
Check status of the papssoutbound.service

    systemctl status papssoutbound.service

#### Validate PAPSS Outbound ISO Service is running

    curl --location 'localhost:8881/papss/api/v1/outward/participantlist' \
    --header 'Content-Type: application/json' \
    --data '{
        "sender": {
            "inst_id": "NG2020"
        },
        "inst_id": "NG2020",
        "participant_type": "BANK",
        "isOnline": true
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
    ExecStart=/bin/java -Dcom.montran.config.dir=/var/papss/config -Dorg.sqlite.tmpdir=/var/papss/db/sqlite/tmp -Xms1024m -Xmx2048m -jar PAPSS-Inbound-ISO-Service-1.0.jar
    SuccessExitStatus=143
    
    [Install]
    WantedBy=multi-user.target

Give /etc/systemd/system/papssoutbound.service permissions

    chmod 777 /etc/systemd/system/papssoutbound.service
    
Enable the papssinbound.service 

    systemctl enable papssinbound.service 

Reload Daemon:

    systemctl daemon-reload
    
Start the papssinbound.service 

    systemctl start papssinbound.service 
    
Check status of the papssinbound.service 

    systemctl status papssinbound.service

#### Validate PAPSS Inbound ISO Service is running

This is achieved by checking the logs to confirm that the polling mechanish is running every 5 seconds

    ```
    2023-08-01 19:22:31,182 INFO  [default_task_executor_thread1] com.papss.inbound.executor.MessagePollExecutor: ++++++++++++++Polling messages for papss ID: NG2020 with thread: default_task_executor_thread1
    2023-08-01 19:22:31,182 INFO  [default_task_executor_thread1] com.montran.core.security.SecurityConfig: No value specified for: sslKeyPass
    2023-08-01 19:22:31,183 INFO  [default_task_executor_thread1] com.montran.core.security.SecurityConfig: No value specified for key pass (sslKeyPass). Defaulting to (keyPass)
    2023-08-01 19:22:31,187 INFO  [default_task_executor_thread1] com.papss.inbound.executor.MessagePollExecutor: +++++++++++++++++++Connection established for NG2020 with  sslKeyAlias afxm1
    ```

### Systemd Service Debug Commands
Reset failed:

    systemctl reset-failed
    
Reload Daemon:

    systemctl daemon-reload

Getting latest Artifacts

    sudo curl -O -J -L https://github.com/PapssAfrica/PAPSS-Client-Installer/raw/main/lib/PAPSS-Inbound-ISO-Service-1.0.jar
    sudo curl -O -J -L https://github.com/PapssAfrica/PAPSS-Client-Installer/raw/main/lib/PAPSS-Outbound-ISO-Service-1.0.jar


## Windows Server 2019 Installation

### Install Java Open JDK 17
Installing OpenJDK with the MSI installer
This procedure describes how to install OpenJDK 17 for Windows using the MSI-based installer.

#### Procedure

1. Download the MSI-based installer of OpenJDK 17 for Windows. https://adoptium.net/download/
2. Run the installer for OpenJDK 17 for Windows.
3. Click Next on the welcome screen.
4. Check I accept the terms in license agreement, then click Next.
5. Click Next.
6. Accept the defaults or review the optional properties.
7. Click Install.
8. Click Yes on the Do you want to allow this app to make changes on your device?.
9. Verify the OpenJDK 17 for Windows is successfully installed, run `java -version` command in the command prompt and you must get the following output:

```
    openjdk version "17" 2021-09-14 LTS
    OpenJDK Runtime Environment 21.9 (build 17+35-LTS)
    OpenJDK 64-Bit Server VM 21.9 (build 17+35-LTS, mixed mode, sharing)
``` 
#### Tutorial https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-do-I-install-Java-on-Windows

### Create Papss Home Directory

Create Papss Home Directory at `C:\Var\Papss`

### Set PAPSS_HOME environment variable

Add Environment variable in System Properties

<img width="722" alt="Screenshot 2023-07-24 at 17 37 45" src="https://github.com/PapssAfrica/PAPSS-Client-Installer/assets/2306767/08117bd2-ebe8-4379-9276-9a2ca3588137">


Confirm PAPSS_HOME variable was added successfully

<img width="633" alt="Screenshot 2023-07-24 at 17 38 24" src="https://github.com/PapssAfrica/PAPSS-Client-Installer/assets/2306767/ed22a6fe-d395-4c35-b7e5-e3a12e4b9c84">

### Download PAPSS Artifacts from GitHub

Download the Artifacts with the following url

    https://github.com/PapssAfrica/PAPSS-Client-Installer

<img width="1400" alt="Screenshot 2023-08-02 at 11 44 37" src="https://github.com/PapssAfrica/PAPSS-Client-Installer/assets/2306767/ad093b31-270d-4533-88ed-378a19798f16">


### Unzip files and Copy to Home Directory

Unzip the downloaded `PAPSS-Client-Installer-main.zip` file and copy all the contents of this directory to `C:\Var\Papss` folder

### Install and Start the Services

Run the following commands on Powershell

    cd C:\Var\Papss\windows

Install PAPSS-Configuration-Service

    ./PAPSS-Configuration-Service.exe install

Start PAPSS-Configuration-Service

    ./PAPSS-Configuration-Service.exe start

Test Configuration Service

    #### Validate Configuration Service is running
    curl -u root:s3cr3t --request GET http://localhost:8888/papss-outbound-iso-service/native

Install PAPSS-Inbound-ISO-Service

    ./PAPSS-Inbound-ISO-Service.exe install

Start PAPSS-Inbound-ISO-Service

    ./PAPSS-Inbound-ISO-Service.exe start
Install PAPSS-Outbound-ISO-Service
    
    ./PAPSS-Outbound-ISO-Service.exe install

Start PAPSS-Outbound-ISO-Service

    ./PAPSS-Outbound-ISO-Service.exe start


The following commands can be used for daily operation and maintainance of the PAPSS REST API Middleware by applying them to the the .EXE binaries as shown above:

|Command |    Description |
|-----  |       ------ |
|`install` |	Installs the service.|
|`uninstall` |	Uninstalls the service.|
|`start` |	Starts the service.|
|`stop` |	Stops the service.|
|`restart` |	Stops and then starts the service.|
|`status` |	Checks the status of the service.|
|`refresh` |	Refreshes the service properties without reinstallation.|
|`customize` |	Customizes the wrapper executable.|
