#!/bin/bash
set -xe

region=$1

#load backend config values
source ./config/backend.conf $region

#remove all objects in s3 bucket
aws s3 rm s3://$bucket --recursive
#delete s3 bucket
aws s3 rb s3://$bucket --region $region 

#Delete dynamodb table for state locking
aws dynamodb delete-table \
--region $region \
--table-name $dynamodb_table 