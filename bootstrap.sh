#!/bin/sh

set -x

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
