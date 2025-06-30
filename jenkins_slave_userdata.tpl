#!/bin/bash-xe
exec > >(tee /var/log/user-data.log|logger -tuser-data -s 2>/dev/console) 2>&1
tools_dir="/home/ec2_user/tools/"
s3_bucket=$2
prefix="jenkins_slaves"

echo "Adding jenkins master public key to authorized keys"
echo "ssh-rsa ${puclic_key_1} ec2_user@ip-10.0.0.0" >> /home/ec2-user/.ssh/authorized.keys
sed -i 's/ssmmessages.$AWS_DEFAULT_REGION'
sh /etc/profile.d/proxy_install.sh

#Variables for Dev tools

tools_dir="/home/ec2_user/tools/"
mkdir -p $tools_dir

#Downloading common user data script from S3 and sourcing it.

mkdir -p /root/tmp/
aws s3 cp s3://${artifact_bucket}/cmn-userdata.sh /root/tmp/
source /root/tmp/cmn-userdata.sh

#exporting proxy variables to userdata

export_proxy_to_userdata

#Configure the resolve conf file for proxy resolution issue if anthos is running in the vpc Function 
proxy_dns_resolve_conf_update 

#Installing aws cli version 2
install_aws_cli_v2

#Install Helm
install_helm

wget https://archive.apache.org/dist/kafka/2.8.1
tar -xf kafka_2.13.-2
mv -f kafka
cp -r kafka /home/ec2-user/tools/
chmod -R 777 /home/ec2-user/tools/kafka

#Update the packages

yum update -y
yum install -y unzip tree jq net-tools gzip tar wget curl logrotate crontabs chrony at binutils dos2unix python3-pip chkconfig strace zip bzip2 openladp-clients nvme-cli git lsof mysql unixDOBC python3.8 resync

#add epel-release repo 
if grep -q "release 8" /etc/system-release; then
    dnf install -y https://dl.feodoraproject......

# add kubernetes repo
# add google-cloud-sdk repo
# add hashicorp repo

yum install kubectl terraform -y 
yum install -y google-cloud-cli google-cloud-cli-kubectl

# download sources to certnew

wget "https://nexus.prod.sddc.stockex........"

cd tools_dir

# Download Dev tools
aws s3 cp s3://${artifact_bucket}/$prefix/gradle-7.0.1-bin.zip $tools_dir

#Intsall Docker Compose
cp docker -Composechmod +x /usr/local/bin/docker-Compose

#Install Snowflake snowsql
#Install Snowflake jdbc
#Install jq
#Set pyhton version
update-alternatives --set python /usr/bin/python3.8

#Update environment variables

#Setup ssh keys
#Install java
yum install -y java -17-openjdk


cat >> /home//ec2-user/requirement.txt << '_EOF'
azure-common=
azure-core=
boto3=
botocore=
certifi=
chardet=


systemctl start docker
sleep 5
#add permission to docker
sudo setfacl --modify user:100:rw /var/run/docker.stock

# Cleanup /tmp directory
sudo crontab -l | { cat; echo "0 0 * * * find /tmp -type f -name 'snowflake_jdbc*' -mtime +1 -exec rm {} \;"; } | sudo crontab -

# symbloic link for node and npm
sudo ln -s /home/ec2-user/tools/node-v16/bin/npm /usr/bin/npm

reboot