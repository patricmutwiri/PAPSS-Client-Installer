sudo groupadd -r papss
sudo useradd -r -s /bin/false -g papss papss
id papss

sudo mv papssinbound.service /etc/systemd/system/ && sudo chmod 0644 /etc/systemd/system/papssinbound.service
sudo mv papssoutbound.service /etc/systemd/system/ && sudo chmod 0644 /etc/systemd/system/papssoutbound.service
sudo mv papssconfig.service /etc/systemd/system/ && sudo chmod 0644 /etc/systemd/system/papssconfig.service

sudo chown -R root:root /etc/systemd/system/papssinbound.service
sudo chown -R root:root /etc/systemd/system/papssoutbound.service
sudo chown -R root:root /etc/systemd/system/papssconfig.service

sudo chown -R papss:papss /app/papss
sudo systemctl daemon-reload
java -version

sudo systemctl start papssoutbound.service
sudo systemctl start papssinbound.service
sudo systemctl start papssconfig.service

sudo systemctl status papssinbound.service
sudo systemctl status papssoutbound.service
sudo systemctl status papssconfig.service




