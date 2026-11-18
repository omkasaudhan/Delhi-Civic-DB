<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registration Successful — Delhi Civic Portal</title>
<link rel="stylesheet" href="/css/style.css">
<style>
  body {
    min-height: 100vh; display: flex; flex-direction: column;
    background: linear-gradient(160deg, #0d2550 0%, #1e4a8f 55%, #e8820c22 100%);
  }
  .success-layout { flex: 1; display: flex; align-items: center; justify-content: center; padding: 40px 20px; }
  .success-card {
    background: #fff; border-radius: 16px;
    box-shadow: 0 8px 48px rgba(10,30,70,0.28);
    max-width: 420px; width: 100%;
    text-align: center; overflow: hidden;
  }
  .success-top {
    background: linear-gradient(135deg, #1a5e34 0%, #22804a 100%);
    color: #fff; padding: 36px 32px 28px;
  }
  .success-icon {
    width: 72px; height: 72px;
    background: rgba(255,255,255,0.18);
    border-radius: 50%; margin: 0 auto 16px;
    display: flex; align-items: center; justify-content: center;
    font-size: 36px;
    animation: popIn 0.5s cubic-bezier(0.17,0.89,0.32,1.28);
  }
  @keyframes popIn {
    0% { transform: scale(0); opacity: 0; }
    100% { transform: scale(1); opacity: 1; }
  }
  .success-top h1 { font-size: 22px; font-weight: 800; margin-bottom: 6px; }
  .success-top p  { font-size: 13px; opacity: 0.80; }
  .success-body { padding: 32px; }
  .success-body p { color: var(--text-muted); font-size: 14.5px; margin-bottom: 24px; line-height: 1.7; }
  .confetti { font-size: 28px; letter-spacing: 6px; margin-bottom: 10px; }
</style>
</head>
<body>

<nav class="navbar">
  <a href="/lgn" class="navbar-brand">
    <div class="brand-icon">D</div>
    <div class="brand-text">
      <span class="brand-title">Delhi Portal</span>
      <span class="brand-sub">Civic Registration System</span>
    </div>
  </a>
  <div class="navbar-links">
    <a href="/lgn">Login</a>
    <a href="/viewjsp">View Records</a>
  </div>
</nav>

<div class="success-layout">
  <div class="success-card">
    <div class="success-top">
      <div class="success-icon">✅</div>
      <div class="confetti">🎉 🎊 🎉</div>
      <h1>Registration Successful!</h1>
      <p>The resident has been successfully registered in the Delhi Civic Database.</p>
    </div>
    <div class="success-body">
      <p>Your registration has been saved. You can view all registered residents or go back to register another entry.</p>
      <div class="btn-group" style="justify-content:center;">
        <a href="/lgn" class="btn btn-secondary">← Register Another</a>
        <a href="/viewjsp" class="btn btn-primary">📋 View All Records</a>
      </div>
    </div>
  </div>
</div>

<footer class="footer" style="background: rgba(0,0,0,0.3);">
  &copy; 2026 Delhi Civic Portal &nbsp;|&nbsp; Government of NCT of Delhi
</footer>

</body>
</html>
