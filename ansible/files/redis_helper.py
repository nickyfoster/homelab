import logging
import os

import boto3
import argparse
import redisdl
from botocore.credentials import InstanceMetadataProvider, InstanceMetadataFetcher
from botocore.exceptions import ClientError
import sys

redis_host = "127.0.0.1"
bucket_name = "redis-backups-229"
filename = f"{os.getcwd()}/redis-dump-test.rdb"  # TODO changeme


def upload_file(file_name, bucket, object_name=None):
    provider = InstanceMetadataProvider(iam_role_fetcher=InstanceMetadataFetcher(timeout=1000, num_attempts=2))
    creds = provider.load().get_frozen_credentials()
    s3_client = boto3.client('s3', region_name='us-east-2',
                             aws_access_key_id=creds.access_key,
                             aws_secret_access_key=creds.secret_key,
                             aws_session_token=creds.token)

    if object_name is None:
        object_name = os.path.basename(file_name)

    try:
        s3_client.upload_file(file_name, bucket, object_name)
    except ClientError as e:
        logging.error(e)
        return False
    return True


def dump():
    with open(filename, 'w') as f:
        redisdl.dump(f, host=redis_host)

    upload_file(filename, bucket_name)


def init():
    parser = argparse.ArgumentParser(
        prog='ProgramName',
        description='What the program does',
        epilog='Text at the bottom of help')

    parser.add_argument('--action', type=str, required=True)  # Parse the argument
    args = parser.parse_args()


def main():
    action = sys.argv[1]
    if not action or action not in ["dump", "load"]:
        print("Please, specify either ")

    print(action)
    # dump()


if __name__ == '__main__':
    main()
