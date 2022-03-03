import json
import os

def lambda_handler(event, context):
    return os.getenv("ENVIRONMENT_NAME")