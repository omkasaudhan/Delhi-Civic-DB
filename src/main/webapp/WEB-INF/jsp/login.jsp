<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="h" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login — Delhi Civic Portal</title>
<link rel="stylesheet" href="/css/style.css">
<style>
  body { display: flex; flex-direction: column; min-height: 100vh; }
  .login-layout {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px 20px;
    background: linear-gradient(160deg, #0d2550 0%, #1e4a8f 55%, #e8820c22 100%);
  }
  .login-card {
    width: 100%; max-width: 420px;
    background: #fff;
    border-radius: 16px;
    box-shadow: 0 8px 48px rgba(10,30,70,0.28);
    overflow: hidden;
  }
  .login-top {
    background: linear-gradient(135deg, #1a3a6e 0%, #2558a8 100%);
    color: #fff;
    padding: 36px 36px 28px;
    text-align: center;
    position: relative;
  }

  .login-seal {
    width: 58px; height: 58px;
    background: rgba(255,255,255,0.14);
    border-radius: 50%; margin: 0 auto 14px;
    display: flex; align-items: center; justify-content: center;
    font-size: 26px;
  }
  .login-top h1 { font-size: 21px; font-weight: 800; margin-bottom: 4px; }
  .login-top p  { font-size: 12.5px; opacity: 0.78; }
  .login-body { padding: 32px 36px 28px; }
  .login-body .form-group { margin-bottom: 18px; }

  .quick-links {
    display: flex; gap: 10px; justify-content: center; padding: 0 36px 24px;
    flex-wrap: wrap;
  }
  .quick-links a {
    display: flex; align-items: center; gap: 5px;
    padding: 8px 18px;
    border-radius: 7px;
    font-size: 13px; font-weight: 500;
    text-decoration: none;
    transition: background 0.2s, color 0.2s;
  }
  .ql-view     { background: #edf1f8; color: #1a3a6e; border: 1px solid #c3d4ed; }
  .ql-view:hover { background: #1a3a6e; color: #fff; }
  .ql-api      { background: #fff4e9; color: #c46b08; border: 1px solid #f5ccaa; }
  .ql-api:hover { background: #e8820c; color: #fff; }
</style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
  <a href="/lgn" class="navbar-brand">
    <div class="brand-icon">
    	D
    </div>
    <div class="brand-text">
      <span class="brand-title">Delhi Portal</span>
      <span class="brand-sub">Civic Registration System</span>
    </div>
  </a>
  <div class="navbar-links">
    <a href="/lgn" class="active">Login</a>
    <a href="/viewjsp">View Records</a>
  </div>
</nav>

<!-- Login Layout -->
<div class="login-layout">
  <div class="login-card">

    <!-- Top brand area -->
    <div class="login-top">
      <div class="login-seal">🏛️</div>
      <h1>Welcome Back</h1>
      <p>Sign in to your account to continue</p>
    </div>

    <!-- Form -->
    <div class="login-body">
      <h:form action="loginUser" modelAttribute="lg">

        <div class="form-group">
          <label for="uid">User ID</label>
          <div class="input-group">
            <span class="input-icon">👤</span>
            <h:input path="uid" id="uid" cssClass="form-control" placeholder="Enter your user ID" />
          </div>
        </div>

        <div class="form-group">
          <label for="pass">Password</label>
          <div class="input-group">
            <span class="input-icon">🔒</span>
            <h:password path="pass" id="pass" cssClass="form-control" placeholder="Enter your password" />
          </div>
        </div>

        <div style="background:#eef4ff;border:1px solid #c3d7f7;border-radius:8px;padding:8px 12px;margin-bottom:16px;font-size:12.5px;color:#1a3a6e;">
          💡 <strong>Demo Credentials:</strong> User ID: <code>admin</code> | Password: <code>admin</code>
        </div>

        <button type="submit" class="btn btn-primary btn-full" style="margin-top:8px;">
          Sign In &rarr;
        </button>
      </h:form>
    </div>

    <!-- Quick Links -->
    <div class="quick-links">
      <a href="/viewjsp" class="ql-view">📋 View Records</a>
      <a href="/viewRest" class="ql-api">⚙️ REST API</a>
    </div>

  </div>
</div>

<!-- Footer -->
<footer class="footer">
  &copy; 2026 Delhi Civic Portal &nbsp;|&nbsp; Government of NCT of Delhi
</footer>

</body>
</html>
