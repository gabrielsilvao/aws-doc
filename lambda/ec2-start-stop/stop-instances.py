from logging import Filter
import boto3

ec2 = boto3.resource('ec2')

def lambda_handler(event, context):
    filters = [{
        'Name': 'tag:STOP',
        'Values': ['EC2']
    },
    {
        'Name': 'instance-state-name',
        'Values': ['running']
    }]

    instances = ec2.instances.filter(Filters=filters)
    RunningInstances = [instance.id for instance in instances]
    print(RunningInstances)
    if len(RunningInstances) > 0:
        shuttingDown = ec2.instances.filter(InstanceIds=RunningInstances).stop()
        print("Stopping instances")
    else:
        print("Not found instances in RUNNING state")

    return 'The code worked'