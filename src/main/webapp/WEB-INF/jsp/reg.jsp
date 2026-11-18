<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registration — Delhi Civic Portal</title>
<link rel="stylesheet" href="/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
  body { display: flex; flex-direction: column; min-height: 100vh; }
  .reg-wrapper {
    flex: 1;
    display: flex;
    align-items: flex-start;
    justify-content: center;
    padding: 40px 20px 60px;
    background: var(--bg);
  }

  /* Stepper bar */
  .stepper {
    display: flex; align-items: center; gap: 0;
    margin-bottom: 28px;
  }
  .step {
    display: flex; align-items: center; gap: 8px;
    font-size: 13px; font-weight: 600; color: var(--text-muted);
  }
  .step-num {
    width: 28px; height: 28px; border-radius: 50%;
    background: var(--border); color: #fff;
    display: flex; align-items: center; justify-content: center;
    font-size: 12px; font-weight: 700;
  }
  .step.active .step-num { background: var(--accent); }
  .step.active { color: var(--text); }
  .step-line { flex: 1; height: 2px; background: var(--border); margin: 0 8px; min-width: 24px; }

  /* Select district spinner */
  #dist-loading { display: none; font-size: 12px; color: var(--text-muted); padding: 4px 0; }
  #dist-loading.show { display: block; }

  .select-hint { font-size: 11.5px; color: var(--text-muted); margin-top: 5px; }
</style>
<script>
$(document).ready(function(){

  $("#stCode").change(function(){
    var sCode = $(this).val();
    if (!sCode || sCode === "0") {
      $("#ddcode").html('<option value="">— Select District —</option>');
      return;
    }
    $("#dist-loading").addClass("show");
    $("#ddcode").html('<option value="">Loading...</option>').prop("disabled", true);

    $.ajax({
      url : "dist?sCode=" + sCode,
      type: "GET",
      success: function(data){
        $("#dist-loading").removeClass("show");
        $("#ddcode").prop("disabled", false).empty();
        $("#ddcode").append('<option value="">— Select District —</option>');
        for(var i = 0; i < data.length; i++){
          $("#ddcode").append('<option value="' + data[i].distCode + '">' + data[i].distName + '</option>');
        }
      },
      error: function(){
        $("#dist-loading").removeClass("show");
        $("#ddcode").prop("disabled", false).html('<option value="">Error loading districts</option>');
      }
    });
  });

  /* Button loading state on submit */
  $("form").on("submit", function(){
    var $btn = $(this).find("button[type=submit]");
    $btn.addClass("loading").text("Saving...");
  });
});
</script>
</head>
<body>

<!-- Navbar -->
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

<!-- Content -->
<div class="reg-wrapper">
  <div class="card card-wide" style="max-width:640px;">

    <!-- Card Header -->
    <div class="card-header">
      <div class="header-icon">📝</div>
      <h2>New Resident Registration</h2>
      <p>Fill in the details below to register a new resident record</p>
    </div>

    <div class="card-body">

      <!-- Stepper -->
      <div class="stepper">
        <div class="step active">
          <div class="step-num">1</div>
          <span>Location</span>
        </div>
        <div class="step-line"></div>
        <div class="step active">
          <div class="step-num">2</div>
          <span>Personal Info</span>
        </div>
        <div class="step-line"></div>
        <div class="step">
          <div class="step-num">3</div>
          <span>Confirm</span>
        </div>
      </div>

      <f:form action="regSave" modelAttribute="rr">

        <!-- Location Row -->
        <div class="form-row">
          <div class="form-group">
            <label for="stCode">State</label>
            <f:select path="stCode" id="stCode" cssClass="form-control">
              <f:option value="0">— Select State —</f:option>
              <f:options items="${modiji}" itemValue="stCode" itemLabel="stName"/>
            </f:select>
          </div>

          <div class="form-group">
            <label for="ddcode">District</label>
            <f:select path="distCode" id="ddcode" cssClass="form-control">
              <f:option value="">— Select District —</f:option>
            </f:select>
            <div id="dist-loading">⏳ Loading districts…</div>
            <p class="select-hint">Select a state first to load districts.</p>
          </div>
        </div>

        <hr style="border:none;border-top:1px solid var(--border);margin:8px 0 20px;">

        <!-- Personal Info Row -->
        <div class="form-row">
          <div class="form-group">
            <label for="name">Full Name</label>
            <div class="input-group">
              <span class="input-icon">👤</span>
              <f:input path="name" id="name" cssClass="form-control" placeholder="e.g. Ramesh Kumar" />
            </div>
          </div>

          <div class="form-group">
            <label for="phone">Phone Number</label>
            <div class="input-group">
              <span class="input-icon">📞</span>
              <f:input path="phone" id="phone" cssClass="form-control" placeholder="10-digit mobile number" />
            </div>
          </div>
        </div>

        <!-- Actions -->
        <div class="btn-group" style="margin-top:12px;">
          <button type="submit" class="btn btn-primary" style="min-width:160px;">
            ✅ Register
          </button>
          <a href="/lgn" class="btn btn-outline">← Back to Login</a>
          <a href="/viewjsp" class="btn btn-secondary" style="margin-left:auto;">📋 View Records</a>
        </div>

      </f:form>
    </div>
  </div>
</div>

<footer class="footer">
  &copy; 2026 Delhi Civic Portal &nbsp;|&nbsp; Government of NCT of Delhi
</footer>

</body>
</html>
