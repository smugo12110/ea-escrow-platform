const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const bodyParser = require('body-parser');

// Load environment variables
dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Health Check Endpoint
app.get('/api/health', (req, res) => {
  res.status(200).json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    environment: process.env.NODE_ENV || 'development'
  });
});

// Root endpoint
app.get('/', (req, res) => {
  res.json({
    name: 'EA Escrow Platform',
    version: '2.0.0',
    status: 'running',
    documentation: 'Open index.html in browser for full documentation'
  });
});

// Example escrow endpoint (placeholder)
app.post('/api/escrow/create', (req, res) => {
  const { buyerPhone, sellerPhone, amount, sourceCurrency, payoutCurrency } = req.body;
  
  // Validation
  if (!buyerPhone || !sellerPhone || !amount) {
    return res.status(400).json({ error: 'Missing required fields' });
  }

  // Generate escrow ID
  const escrowId = `TX-ESCROW-${Date.now()}`;

  res.status(201).json({
    success: true,
    escrowId,
    status: 'pending_funding',
    amount,
    sourceCurrency,
    payoutCurrency,
    message: 'Escrow created successfully. Awaiting funding.'
  });
});

// Get escrow status
app.get('/api/escrow/:escrowId', (req, res) => {
  const { escrowId } = req.params;

  res.json({
    escrowId,
    status: 'pending_funding',
    amount: 250000,
    riskLevel: 'low',
    createdAt: new Date().toISOString()
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    error: 'Internal Server Error',
    message: process.env.NODE_ENV === 'development' ? err.message : undefined
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    error: 'Not Found',
    message: 'Endpoint does not exist'
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 EA Escrow Platform API running on port ${PORT}`);
  console.log(`📚 Documentation: http://localhost:${PORT}`);
  console.log(`🏥 Health check: http://localhost:${PORT}/api/health`);
});

module.exports = app;