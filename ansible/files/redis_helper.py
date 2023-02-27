import argparse
import logging
import os

import boto3
from botocore.credentials import InstanceMetadataProvider, InstanceMetadataFetcher
from botocore.exceptions import ClientError

import redisdl

redis_host = "127.0.0.1"
bucket_name = "redis-backups-229"
filename = f"{os.getcwd()}/redis-dump.rdb"
aws_region = "us-east-2"

logging.basicConfig(format='%(asctime)s (%(module)s:%(lineno)d) %(levelname)s: %(message)s',
                    handlers=[
                        logging.FileHandler("main.redis_helper.log"),
                        logging.StreamHandler()
                    ],
                    encoding='utf-8',
                    level=logging.INFO)

logger = logging.getLogger(__name__)


def get_s3():
    provider = InstanceMetadataProvider(iam_role_fetcher=InstanceMetadataFetcher(timeout=1000, num_attempts=2))
    creds = provider.load().get_frozen_credentials()
    return boto3.client('s3', region_name=aws_region,
                        aws_access_key_id=creds.access_key,
                        aws_secret_access_key=creds.secret_key,
                        aws_session_token=creds.token)


def __upload_file(file_name, bucket, object_name=None):
    s3_client = get_s3()
    if object_name is None:
        object_name = os.path.basename(file_name)
    try:
        s3_client.upload_file(file_name, bucket, object_name)
    except ClientError as e:
        logger.error(e)
        return False
    logger.info("Redis DB dumper. File uploaded successfully to S3!")
    return True


def __download_file(file_name, bucket, object_name):
    s3_client = get_s3()
    try:
        s3_client.download_file(bucket, object_name, file_name)
    except ClientError as e:
        logger.error(e)
        return False


def dump():
    with open(filename, 'w') as f:
        redisdl.dump(f, host=redis_host)

    __upload_file(filename, bucket_name)
    os.remove(filename)


def load():
    __download_file(bucket=bucket_name, object_name=filename.split("/")[-1], file_name=filename)

    with open(filename) as f:
        redisdl.load(f)
    os.remove(filename)

    logger.info("Redis DB loaded from file successfully!")


def main():
    parser = argparse.ArgumentParser(
        prog='Redis DB helper tool',
        description='Easily dump and load Redis backups from S3 storage')

    parser.add_argument('--method', type=str, required=True,
                        choices=['load', 'dump'],
                        help='choose either "load" or "dump"')
    args = parser.parse_args()
    method = args.method

    logger.info(f"Preparing to perform {method} method")

    if method == "dump":
        dump()

    if method == "load":
        load()


if __name__ == '__main__':
    main()
