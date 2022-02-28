import boto3
region = 'us-east-1'
instances = ['i-020e01af6c81f98d9'
'i-0ba5e4415b40ec320',
'i-07f627887e710da65',
'i-0cd0b0034b6aa933c',
'i-02fb54749187f1e84',
'i-01d058265d749b9e3',
'i-0a4aff8f52daba2e2',
'i-031534a394cc2ba54',
'i-04e3e30b7bd74f7d7',
'i-041ca90d554c4faf4',
'i-0d7601363ea10645b',
'i-0ac46c6a28848af60',
'i-02cc881399eb7b348',
'i-09fd2531a8f6e2778',
'i-0a1151d231c8b9760',
'i-0172aaeed09d6f4ba']
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    ec2.start_instances(InstanceIds=instances)
    print('started your instance: ' + str(instances))