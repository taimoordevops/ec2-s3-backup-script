#!/bin/bash

# Define the SNS topic ARN
SNS_TOPIC="arn:aws:sns:eu-north-1:555769391999:EC2BackupAlerts"

# Fetch instance ID securely using IMDSv2
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/instance-id)

# CPU Utilization Alarm
aws cloudwatch put-metric-alarm --alarm-name "EC2-CPU-Usage-Alarm" \
  --metric-name CPUUtilization --namespace AWS/EC2 \
  --statistic Average --period 300 --threshold 70 \
  --comparison-operator GreaterThanThreshold --evaluation-periods 1 \
  --dimensions Name=InstanceId,Value=$INSTANCE_ID \
  --alarm-actions $SNS_TOPIC --region eu-north-1

# EC2 Free Tier Hours Usage
aws cloudwatch put-metric-alarm --alarm-name "EC2-Hours-FreeTier" \
  --namespace "AWS/Usage" --metric-name "ResourceCount" \
  --dimensions Name=Service,Value=AmazonEC2 Name=Type,Value=Resource Name=Resource,Value=Global-BoxUsage:freetier.micro \
  --statistic Maximum --period 86400 --threshold 525 \
  --comparison-operator GreaterThanThreshold --evaluation-periods 1 \
  --alarm-actions $SNS_TOPIC --region eu-north-1

# S3 Tier 1 Request Count
aws cloudwatch put-metric-alarm --alarm-name "S3-Requests-Tier1" \
  --namespace "AWS/Usage" --metric-name "RequestCount" \
  --dimensions Name=Service,Value=AmazonS3 Name=Type,Value=Request Name=Resource,Value=Global-Requests-Tier1 \
  --statistic Sum --period 86400 --threshold 1400 \
  --comparison-operator GreaterThanThreshold --evaluation-periods 1 \
  --alarm-actions $SNS_TOPIC --region eu-north-1

# EBS Volume Usage
aws cloudwatch put-metric-alarm --alarm-name "EBS-Storage-FreeTier" \
  --namespace "AWS/Usage" --metric-name "ResourceCount" \
  --dimensions Name=Service,Value=AmazonEBS Name=Type,Value=Resource Name=Resource,Value=Global-EBS:VolumeUsage \
  --statistic Maximum --period 86400 --threshold 21 \
  --comparison-operator GreaterThanThreshold --evaluation-periods 1 \
  --alarm-actions $SNS_TOPIC --region eu-north-1

# Public IPv4 Usage
aws cloudwatch put-metric-alarm --alarm-name "IPv4-Usage-FreeTier" \
  --namespace "AWS/Usage" --metric-name "ResourceCount" \
  --dimensions Name=Service,Value=AmazonVPC Name=Type,Value=Resource Name=Resource,Value=Global-PublicIPv4:InUseAddress \
  --statistic Maximum --period 86400 --threshold 525 \
  --comparison-operator GreaterThanThreshold --evaluation-periods 1 \
  --alarm-actions $SNS_TOPIC --region eu-north-1

echo "✅ Free Tier usage alarms created!"

