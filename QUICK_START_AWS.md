# ⚡ Quick Start: Deploy in 30 Minutes

## Prerequisites
- AWS Account
- SSH key pair
- Domain name
- M-Pesa credentials

## Step 1: Launch EC2 Instance (5 min)

1. Go to AWS Console → EC2
2. Click "Launch Instance"
3. Select Ubuntu 22.04 LTS
4. Instance type: t3.small
5. Storage: 30GB
6. Security Group: Allow ports 22, 80, 443
7. Launch!

## Step 2: Create RDS Database (5 min)

1. Go to RDS Console
2. Create database
3. Engine: PostgreSQL 15
4. Instance type: db.t3.micro
5. Storage: 20GB
6. Database name: escrow_prod
7. Create!

## Step 3: SSH into Instance (2 min)

```bash
ssh -i your-key.pem ubuntu@your-instance-ip
```

## Step 4: Deploy (10 min)

```bash
git clone https://github.com/smugo12110/ea-escrow-platform.git
cd ea-escrow-platform
bash deploy.sh
```

The script will:
- Update system packages
- Install Node.js, PostgreSQL, Nginx
- Install dependencies
- Setup SSL certificate
- Start services with PM2

## Step 5: Configure DNS (2 min)

Point your domain to EC2 instance IP:
```
A Record: api.eascrow.io → your-instance-public-ip
```

## Step 6: Verify (2 min)

```bash
curl https://api.eascrow.io/api/health
# Expected: {"status":"ok"}
```

## ✅ Done!

Your platform is live! 🎉

## Next Steps

1. Update `.env` with M-Pesa credentials
2. Setup CloudWatch monitoring
3. Configure SNS alerts
4. Deploy documentation to S3