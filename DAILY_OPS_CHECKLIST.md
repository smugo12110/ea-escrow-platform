# 📋 Daily Operations Checklist

## 🌅 Morning Checklist (5 minutes)

Run every morning at 8:00 AM:

- [ ] API health check: `curl https://api.eascrow.io/api/health`
- [ ] App status: `pm2 status`
- [ ] Database connection: `psql $DATABASE_URL -c "SELECT 1"`
- [ ] Disk usage < 70%: `df -h /`
- [ ] Memory usage < 70%: `free -h`
- [ ] No alarms in CloudWatch
- [ ] Check Slack for overnight alerts

## 📊 Evening Reconciliation (5 minutes)

Run every evening at 5:00 PM:

```bash
psql $DATABASE_URL -c "
SELECT 
  COUNT(*) as transactions,
  SUM(source_amount_cents) as volume,
  SUM(platform_fee_cents) as revenue
FROM escrows
WHERE DATE(created_at) = CURRENT_DATE"
```

## 📈 Weekly Tasks (Monday Morning)

- [ ] Review CloudWatch metrics (CPU, Memory, Disk trends)
- [ ] Check security logs
- [ ] Verify SSL certificate (valid for > 7 days)
- [ ] Review error logs
- [ ] Update team on platform status

## 🔧 Monthly Tasks (1st of Month)

- [ ] Database maintenance:
  ```bash
  psql $DATABASE_URL -c "VACUUM ANALYZE"
  psql $DATABASE_URL -c "REINDEX DATABASE escrow_prod"
  ```

- [ ] System updates:
  ```bash
  sudo apt update && sudo apt upgrade -y
  npm audit fix
  npm update
  ```

- [ ] Generate financial report
- [ ] Review and update documentation
- [ ] Plan for next month improvements

## 🚨 Troubleshooting

### API Not Responding
```bash
pm2 restart escrow-api
curl https://api.eascrow.io/api/health
```

### Database Down
```bash
aws rds reboot-db-instance --db-instance-identifier escrow-prod-db
```

### High CPU Usage
```bash
pm2 monit  # Identify process
pm2 restart escrow-api  # Restart if needed
```

### Disk Full
```bash
rm -f ~/.pm2/logs/*-*.log.*
df -h  # Verify space freed
```

## 📞 Escalation

If issue not resolved in 5 minutes → Contact L2 engineer
If issue not resolved in 1 hour → Contact manager