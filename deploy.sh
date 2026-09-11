#!/bin/bash

# EA Escrow Platform - Automated Deployment Script
# This script deploys the platform to AWS EC2 + RDS

set -e

echo "🚀 EA Escrow Platform - Deployment Script"
echo "=========================================="

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Step 1: Update system
echo -e "${BLUE}[1/8]${NC} Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Step 2: Install Node.js
echo -e "${BLUE}[2/8]${NC} Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs
node --version

# Step 3: Install PostgreSQL
echo -e "${BLUE}[3/8]${NC} Installing PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Step 4: Install Nginx
echo -e "${BLUE}[4/8]${NC} Installing Nginx..."
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Step 5: Install PM2
echo -e "${BLUE}[5/8]${NC} Installing PM2..."
sudo npm install -g pm2

# Step 6: Clone and install dependencies
echo -e "${BLUE}[6/8]${NC} Installing application dependencies..."
cd /opt/escrow
npm install

# Step 7: Setup environment
echo -e "${BLUE}[7/8]${NC} Setting up environment..."
if [ ! -f .env ]; then
  cp .env.example .env
  echo -e "${GREEN}✓ .env file created. Please update with your credentials.${NC}"
fi

# Step 8: Start application with PM2
echo -e "${BLUE}[8/8]${NC} Starting application..."
pm2 start src/index.js --name "escrow-api"
pm2 save
pm2 startup

echo -e "${GREEN}✅ Deployment Complete!${NC}"
echo "Application is running at: https://api.eascrow.io"
echo "Next: Update .env with your M-Pesa and AWS credentials"