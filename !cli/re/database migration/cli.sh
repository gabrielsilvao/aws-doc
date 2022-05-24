#!/bin/bash

# pegar informações de EC2
ec2-describe-instance() {
    local ec2=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values= CafeInstance" \
    --query "Reservations[*].Instances[*].[InstanceId,InstanceType,PublicDnsName,PublicIpAddress,Placement.AvailabilityZone,VpcId,SecurityGroups[*].GroupId]" | grep i)
    echo $ec2
    return
}

# pegar informações de VPC
ec2-describe-vpcs() {
    local vpc=$(aws ec2 describe-vpcs --vpc-ids vpc-03b840094cf165430 \
    --filters "Name=tag:Name,Values= Cafe VPC" \
    --query "Vpcs[*].CidrBlock" | grep vpc-*)
    return
}

#### arrumar

# pegar informações de subnet
ec2-describe-buckets() {
    aws ec2 describe-subnets \
    --filters "Name=vpc-id,Values=vpc-03b840094cf165430" \
    --query "Subnets[*].[SubnetId,CidrBlock]"
    return
}


# pegar informações de az
ec2-describe-azs() {
    aws ec2 describe-availability-zones \
    --filters "Name=region-name,Values=us-west-2" \
    --query "AvailabilityZones[*].ZoneName"
    return
}

# aws ec2 create-security-group
ec2-describe-sg() {
    aws ec2 create-security-group \
    --group-name CafeDatabaseSG \
    --description "Security group for Cafe database" \
    return
}


# aws permitir regra de entrada no SG

aws ec2 authorize-security-group-ingress \
--group-id sg-00b2ebcfd92d25455 \
--protocol tcp --port 3306 \
--source-group sg-03b290e1db12a4a98

# aws pegar informacoes de security-groups

aws ec2 describe-security-groups \
--query "SecurityGroups[*].[GroupName,GroupId,IpPermissions]" \
--filters "Name=group-name,Values='CafeDatabaseSG'"

# aws criar uma subnet

aws ec2 create-subnet \
--vpc-id vpc-03b840094cf165430 \
--cidr-block 10.200.2.0/23 \
--availability-zone us-west-2a

aws ec2 create-subnet \
--vpc-id vpc-03b840094cf165430 \
--cidr-block 10.200.12.0/23 \
--availability-zone us-west-2b

# aws criar um db subnet group

aws rds create-db-subnet-group \
--db-subnet-group-name "CafeDB Subnet Group" \
--db-subnet-group-description "DB subnet group for Cafe" \
--subnet-ids subnet-03a615403ff9261d2 subnet-0aa7013265edaa649 \
--tags "Key=Name,Value= CafeDatabaseSubnetGroup"

# aws criar um rds

aws rds create-db-instance \
--db-instance-identifier CafeDBInstance \
--engine mariadb \
--engine-version 10.5.13 \
--db-instance-class db.t3.micro \
--allocated-storage 20 \
--availability-zone us-west-2a \
--db-subnet-group-name "CafeDB Subnet Group" \
--vpc-security-group-ids sg-00b2ebcfd92d25455 \
--no-publicly-accessible \
--master-username root --master-user-password 'Re:Start!9'

# aws pegar informacoes de db

aws rds describe-db-instances \
--db-instance-identifier CafeDBInstance \
--query "DBInstances[*].[Endpoint.Address,AvailabilityZone,PreferredBackupWindow,BackupRetentionPeriod,DBInstanceStatus]"

# criar dump

mysqldump --user=root --password='Re:Start!9' \
--databases cafe_db --add-drop-database > cafedb-backup.sql

less cafedb-backup.sql

# insira o dump dentro do novo rds

mysql --user=root --password='Re:Start!9' \
--host=cafedbinstance.c7ef1eozgvv9.us-west-2.rds.amazonaws.com \
< cafedb-backup.sql

# verificar os dados

mysql --user=root --password='Re:Start!9' \
--host=cafedbinstance.c7ef1eozgvv9.us-west-2.rds.amazonaws.com

show databases;
use cafe_db;
show tables;
select * from product;
