<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login Failed — Delhi Civic Portal</title>
<link rel="stylesheet" href="/css/style.css">
<style>
  body {
    min-height: 100vh; display: flex; flex-direction: column;
    background: linear-gradient(160deg, #3d0d0d 0%, #8f1e1e 55%, #e82c0c18 100%);
  }
  .error-layout { flex: 1; display: flex; align-items: center; justify-content: center; padding: 40px 20px; }
  .error-card {
    background: #fff; border-radius: 16px;
    box-shadow: 0 8px 48px rgba(70,10,10,0.28);
    max-width: 420px; width: 100%;
    text-align: center; overflow: hidden;
  }
  .error-top {
    background: linear-gradient(135deg, #8f1e1e 0%, #c0392b 100%);
    color: #fff; padding: 36px 32px 28px;
  }
  .error-icon {
    width: 72px; height: 72px;
    background: rgba(255,255,255,0.18);
    border-radius: 50%; margin: 0 auto 16px;
    display: flex; align-items: center; justify-content: center;
    font-size: 36px;
    animation: shake 0.5s ease;
  }
  @keyframes shake {
    0%,100% { transform: translateX(0); }
    20%,60%  { transform: translateX(-8px); }
    40%,80%  { transform: translateX(8px); }
  }
  .error-top h1 { font-size: 22px; font-weight: 800; margin-bottom: 6px; }
  .error-top p  { font-size: 13px; opacity: 0.80; }
  .error-body { padding: 32px; }
  .error-body p { color: var(--text-muted); font-size: 14.5px; margin-bottom: 24px; line-height: 1.7; }
</style>
</head>
<body>

<nav class="navbar" style="background:#6e1a1a;">
  <a href="/lgn" class="navbar-brand">
    <div class="brand-icon" style="background:#c0392b;">D</div>
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

<div class="error-layout">
  <div class="error-card">
    <div class="error-top">
      <div class="error-icon">❌</div>
      <h1>Login Failed</h1>
      <p>Invalid credentials. Please check your User ID and password.</p>
    </div>
    <div class="error-body">
      <div class="alert alert-error">
        <span class="alert-icon">⚠️</span>
        <span>The User ID or Password you entered is incorrect. Please try again.</span>
      </div>
      <p>Make sure your credentials are correct. If you continue to have issues, contact the system administrator.</p>
      <div class="btn-group" style="justify-content:center;">
        <a href="/lgn" class="btn btn-primary">← Try Again</a>
        <a href="/viewjsp" class="btn btn-outline">📋 View Records</a>
      </div>
    </div>
  </div>
</div>

<footer class="footer" style="background: rgba(0,0,0,0.3);">
  &copy; 2026 Delhi Civic Portal &nbsp;|&nbsp; Government of NCT of Delhi
</footer>

</body>
</html>
