#!/bin/bash

ec2-describe-instance() {
    ec2=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=cli-host" \
    --query "Reservations[*].Instances[*].[InstanceId]" | grep i)
    ec2="${str:1:-1}"
    return
}

func=$(aws ec2 describe-instances --instance-ids $ec2)
echo $func