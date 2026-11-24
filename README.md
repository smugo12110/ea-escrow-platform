# 🚀 EA Escrow Platform

A professional cross-border escrow platform with M-Pesa integration, built for production operations.

## 📋 Quick Start

### Prerequisites
- Node.js >= 18.0.0
- PostgreSQL 15+
- AWS Account (for deployment)
- M-Pesa Business Account

### Installation

```bash
# Clone repository
git clone https://github.com/smugo12110/ea-escrow-platform.git
cd ea-escrow-platform

# Install dependencies
npm install

# Setup environment
cp .env.example .env

# Update .env with your credentials
nano .env

# Start development server
npm run dev
```

## 🚀 Deployment

### AWS Deployment (Automated)

```bash
# 1. Launch EC2 instance (Ubuntu 22.04 LTS)
# 2. SSH into instance
ssh -i your-key.pem ubuntu@your-instance-ip

# 3. Clone and deploy
git clone https://github.com/smugo12110/ea-escrow-platform.git
cd ea-escrow-platform
bash deploy.sh

# 4. Configure DNS
# Point your domain to EC2 instance IP
```
#chrome launch
### Docker Deployment

```bash
docker build -t escrow-api .
docker run -p 3000:3000 --env-file .env escrow-api
```

## 📚 Documentation

- **Website**: Open `index.html` in browser or deploy to S3
- **Quick Start**: See QUICK_START_AWS.md
- **Operations**: See DAILY_OPS_CHECKLIST.md
- **API Docs**: See API_DOCUMENTATION.md

## 🔐 Smart Contracts

Solidity contracts in `contracts/` folder:
- `CrossBorderEscrow.sol` - Main escrow contract

### Compile Contracts

```bash
npm run compile-contracts
```

## 🧪 Testing

```bash
npm test
```

## 📊 Monitoring

Monitoring configured via CloudWatch. See `index.html` for setup guide.

## 🔌 API Endpoints

### Health Check
```bash
GET /api/health
```

### Create Escrow
```bash
POST /api/escrow/create
Body: {
  "buyerPhone": "+254700000000",
  "sellerPhone": "+256700000000",
  "amount": 250000,
  "sourceCurrency": "KES",
  "payoutCurrency": "UGX"
}
```

### Get Escrow Status
```bash
GET /api/escrow/{escrowId}
```

## 📈 Performance Targets

- API Uptime: 99.9%
- Response Time (p95): <100ms
- Error Rate: <0.1%
- Database Latency: <50ms

## 💼 Business Model

- Platform fee: 1-2% per transaction
- Monthly subscription: Optional
- Enterprise pricing: Available

## 📞 Support

- Email: support@eascrow.io
- Docs: https://docs.eascrow.io
- GitHub Issues: Report bugs

## 📄 License

MIT License - See LICENSE file

## ✨ Status

✅ Production Ready
✅ Fully Tested
✅ Documented
✅ Deployed

---

