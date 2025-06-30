import boto3
import botocore
from openpyxl import Workbook

def get_all_s3_buckets():
    s3 = boto3.client('s3')
    response = s3.list_buckets()
    return [bucket['Name'] for bucket in response['Buckets']]

def bucket_has_lifecycle(bucket_name):
    s3 = boto3.client('s3')
    try:
        s3.get_bucket_lifecycle_configuration(Bucket=bucket_name)
        return True
    except botocore.exceptions.ClientError as e:
        if e.response['Error']['Code'] == 'NoSuchLifecycleConfiguration':
            return False
        else:
            raise

def write_to_excel(buckets_without_lifecycle, total_buckets):
    wb = Workbook()
    ws = wb.active
    ws.title = "S3 Buckets Without Lifecycle"

    ws.append(["Bucket Name"])
    for bucket in buckets_without_lifecycle:
        ws.append([bucket])

    ws.append([])
    ws.append(["Total S3 Buckets", total_buckets])
    ws.append(["Buckets Without Lifecycle", len(buckets_without_lifecycle)])

    wb.save("buckets_without_lifecycle.xlsx")

def main():
    print("Checking S3 buckets for lifecycle policies...")
    all_buckets = get_all_s3_buckets()
    buckets_without_lifecycle = []

    for bucket in all_buckets:
        if not bucket_has_lifecycle(bucket):
            buckets_without_lifecycle.append(bucket)
            print(f"❌ No lifecycle policy: {bucket}")
        else:
            print(f"✅ Has lifecycle policy: {bucket}")

    print("\nWriting results to Excel file...")
    write_to_excel(buckets_without_lifecycle, len(all_buckets))
    print("✅ Done! File saved as 'buckets_without_lifecycle.xlsx'")

if __name__ == "__main__":
    main()
