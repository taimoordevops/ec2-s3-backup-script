# 🚀 Project 1: EC2 S3 Backup & Free Tier Monitor

## 📦 Project Overview  
This project automates the process of creating timestamped backup files on an EC2 instance and securely uploads them to an Amazon S3 bucket. It also includes Free Tier usage monitoring with automated alerts to prevent unexpected AWS charges.  

The solution follows AWS best practices with logging, cron automation, and IAM role-based access (no hardcoded credentials).

---

## 🛠️ Features  
✅ Timestamped backup file generation  
✅ Automatic upload to Amazon S3  
✅ Backup activity logging  
✅ Fully automated via cron jobs  
✅ IAM Role-based access (no hardcoded credentials)  
✅ Free Tier Usage Monitoring with CloudWatch & SNS alerts  

---

## 🗂️ Project Structure 
```bash
ec2-s3-backup-script/
├── backup-to-s3.sh          # Main backup script
├── backup-log.txt           # Log file for backup operations
├── free-tier-monitor.sh     # Free Tier usage monitoring script (CloudWatch + SNS)
├── .gitignore               # Ignore unnecessary files
└── README.md                # Project documentation
```
---

## ⚙️ Usage  

Make the scripts executable and run them:

```bash
chmod +x backup-to-s3.sh
./backup-to-s3.sh

chmod +x free-tier-monitor.sh
./free-tier-monitor.sh
```
---
## ♻️ Restore from S3  
---
Ensure your EC2 instance has AWS CLI access (via IAM Role or credentials).  

Make the restore script executable and run it:  
```bash
chmod +x restore.sh  
./restore.sh
```
---
✍️ Author

12+ years software engineer transitioning to AWS/DevOps. Hands-on learner building real-world cloud projects.

---
🌐 Useful Links  
- [AWS S3 Console](https://s3.console.aws.amazon.com/s3/home)  
- **Bucket Name:** `day3-bucket-taimoor` 
