#!/bin/sh

set -x
set -e

# Install Jenkins
yum update -y
yum install wget java-1.8.0-openjdk -y
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
yum install jenkins${jenkins_version} -y

# Start Jenkins
service jenkins start

# Open firewall
# iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -F

# Install EC2 Plugin
sleep 10
curl --retry 60 --retry-delay 1 --max-time 5 --retry-max-time 60 http://0.0.0.0:8080
sleep 10
wget -P /tmp -t 60 -w 1 --retry-connrefused http://0.0.0.0:8080/jnlpJars/jenkins-cli.jar
ls /tmp

pwd=`cat /var/lib/jenkins/secrets/initialAdminPassword`

java -jar /tmp/jenkins-cli.jar -s http://0.0.0.0:8080 -auth admin:$pwd install-plugin https://updates.jenkins-ci.org/download/plugins/ec2/${ec2_plugin_version}/ec2.hpi -restart
