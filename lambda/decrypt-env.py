import boto3
import os

from base64 import b64decode

ENCRYPTED = os.environ['DB_PASSWORD']
DECRYPTED = boto3.client('kms').decrypt(
    CiphertextBlob=b64decode(ENCRYPTED),
    EncryptionContext={'LambdaFunctionName': os.environ['AWS_LAMBDA_FUNCTION_NAME']}
)['Plaintext'].decode('utf-8')

def lambda_handler(event, context):
    print(ENCRYPTED)
    print(DECRYPTED)
    return "great"