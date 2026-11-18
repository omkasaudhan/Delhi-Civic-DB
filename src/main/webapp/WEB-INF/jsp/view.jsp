<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Resident Records & Civic Analytics — Delhi Civic Portal</title>
<link rel="stylesheet" href="/css/style.css">
<style>
  body { display: flex; flex-direction: column; min-height: 100vh; background: #f0f4f8; font-family: 'Segoe UI', system-ui, sans-serif; }
  main { flex: 1; padding: 28px 24px 48px; }

  /* Page Top Banner */
  .page-top {
    background: linear-gradient(135deg, #1a3a6e 0%, #2558a8 100%);
    color: #fff;
    padding: 26px 32px;
    display: flex; align-items: center; justify-content: space-between; gap: 20px;
    flex-wrap: wrap; border-radius: 14px;
    margin-bottom: 24px;
    box-shadow: 0 4px 20px rgba(26,58,110,0.18);
  }
  .page-top-text h1 { font-size: 22px; font-weight: 800; margin-bottom: 4px; display: flex; align-items: center; gap: 10px; }
  .page-top-text p  { font-size: 13px; opacity: 0.82; }
  .page-top-actions { display: flex; gap: 10px; flex-wrap: wrap; }

  /* Analytics Metric Grid */
  .metrics-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
    gap: 16px;
    margin-bottom: 20px;
  }
  .metric-card {
    background: #fff;
    border-radius: 12px;
    padding: 20px 22px;
    box-shadow: 0 2px 14px rgba(26,58,110,0.07);
    border: 1px solid #e1e8f0;
    display: flex; align-items: center; gap: 16px;
    transition: transform 0.2s, box-shadow 0.2s;
  }
  .metric-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(26,58,110,0.12);
  }
  .metric-icon-box {
    width: 48px; height: 48px;
    border-radius: 12px;
    display: flex; align-items: center; justify-content: center;
    font-size: 22px; flex-shrink: 0;
  }
  .icon-blue   { background: #e8f0fe; color: #1a73e8; }
  .icon-green  { background: #e6f4ea; color: #1e8e3e; }
  .icon-orange { background: #fef7e0; color: #f29900; }
  .icon-purple { background: #f3e8fd; color: #9334e6; }

  .metric-info { display: flex; flex-direction: column; }
  .metric-val {
    font-size: 22px; font-weight: 800; color: #1a3a6e; line-height: 1.1; margin-bottom: 4px;
  }
  .metric-title {
    font-size: 11.5px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.6px; color: #5a6e82;
  }

  /* Demographic Breakdown Widget */
  .breakdown-card {
    background: #fff;
    border-radius: 12px;
    padding: 20px 24px;
    margin-bottom: 20px;
    border: 1px solid #e1e8f0;
    box-shadow: 0 2px 14px rgba(26,58,110,0.06);
  }
  .breakdown-header {
    display: flex; align-items: center; justify-content: space-between;
    margin-bottom: 14px;
  }
  .breakdown-title {
    font-size: 14px; font-weight: 700; color: #1a3a6e; display: flex; align-items: center; gap: 8px;
  }
  .breakdown-bars-container {
    display: flex; flex-direction: column; gap: 12px;
  }
  .breakdown-row {
    display: flex; align-items: center; gap: 12px; font-size: 13px;
  }
  .breakdown-label {
    width: 140px; font-weight: 600; color: #2d3e50; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
  }
  .progress-track {
    flex: 1; height: 10px; background: #eef2f7; border-radius: 6px; overflow: hidden; position: relative;
  }
  .progress-fill {
    height: 100%; border-radius: 6px; transition: width 0.6s cubic-bezier(0.4, 0, 0.2, 1);
  }
  .breakdown-stat {
    width: 95px; text-align: right; font-weight: 700; color: #1a3a6e; font-size: 12.5px;
  }

  /* Toolbar: Search + State Filter + Export + Print */
  .toolbar {
    background: #fff;
    border-radius: 12px;
    padding: 16px 20px;
    margin-bottom: 18px;
    border: 1px solid #e1e8f0;
    box-shadow: 0 2px 12px rgba(26,58,110,0.05);
    display: flex; align-items: center; justify-content: space-between;
    gap: 14px; flex-wrap: wrap;
  }
  .search-group {
    display: flex; align-items: center; gap: 10px; flex: 1; min-width: 280px; flex-wrap: wrap;
  }
  .search-box {
    position: relative; flex: 1; min-width: 220px;
  }
  .search-box input {
    width: 100%;
    padding: 9px 14px 9px 38px;
    border: 1.5px solid #d1dbe6;
    border-radius: 8px; font-size: 13.5px;
    outline: none; font-family: inherit;
    transition: border-color 0.2s, box-shadow 0.2s;
  }
  .search-box input:focus {
    border-color: #2558a8;
    box-shadow: 0 0 0 3px rgba(37,88,168,0.12);
  }
  .search-icon-svg {
    position: absolute; left: 12px; top: 50%; transform: translateY(-50%);
    color: #5a6e82; pointer-events: none;
  }

  .filter-select {
    padding: 9px 14px;
    border: 1.5px solid #d1dbe6;
    border-radius: 8px; font-size: 13.5px;
    background: #fff; color: #1e2d3d; outline: none; cursor: pointer;
  }

  .toolbar-actions {
    display: flex; align-items: center; gap: 8px; flex-wrap: wrap; margin-left: auto;
  }

  .row-count-badge {
    background: #edf1f8; color: #1a3a6e;
    font-size: 12.5px; font-weight: 700;
    padding: 6px 14px; border-radius: 20px;
    border: 1px solid #c7d7ed;
  }

  /* Table styling */
  .table-card {
    background: #fff;
    border-radius: 14px;
    border: 1px solid #e1e8f0;
    box-shadow: 0 4px 20px rgba(26,58,110,0.08);
    overflow: hidden;
  }
  table.data-table {
    width: 100%; border-collapse: collapse; text-align: left;
  }
  table.data-table thead {
    background: #1a3a6e; color: #fff;
  }
  table.data-table thead th {
    padding: 13px 16px;
    font-size: 12px; font-weight: 700;
    letter-spacing: 0.6px; text-transform: uppercase;
  }
  table.data-table tbody tr {
    border-bottom: 1px solid #e8eff6;
    transition: background 0.15s;
  }
  table.data-table tbody tr:hover { background: #f6f9fc; }
  table.data-table td {
    padding: 12px 16px;
    font-size: 13.5px;
    color: #1e2d3d;
    vertical-align: middle;
  }

  .loc-pill {
    display: inline-flex; align-items: center; gap: 6px;
    font-weight: 600; color: #1a3a6e;
  }
  .loc-code {
    font-size: 11px; color: #6b8299; font-weight: 500;
    background: #edf1f8; padding: 2px 6px; border-radius: 4px;
  }

  .resident-cell {
    display: flex; align-items: center; gap: 10px; font-weight: 600; color: #1a2c42;
  }
  .resident-avatar {
    width: 32px; height: 32px;
    border-radius: 50%;
    background: linear-gradient(135deg, #2558a8, #1a3a6e);
    color: #fff; font-size: 12.5px; font-weight: 700;
    display: flex; align-items: center; justify-content: center;
    flex-shrink: 0;
  }
  .phone-link {
    color: #1a73e8; text-decoration: none; font-weight: 500;
    display: inline-flex; align-items: center; gap: 5px;
  }
  .phone-link:hover { text-decoration: underline; }

  /* Row Actions */
  .action-buttons {
    display: flex; align-items: center; gap: 6px;
  }
  .btn-action {
    padding: 5px 10px; font-size: 12px; font-weight: 600; border-radius: 6px;
    border: none; cursor: pointer; text-decoration: none; display: inline-flex; align-items: center; gap: 4px;
    transition: background 0.15s;
  }
  .btn-id-card {
    background: #eef4ff; color: #1a73e8; border: 1px solid #c7d7f7;
  }
  .btn-id-card:hover { background: #1a73e8; color: #fff; }
  .btn-delete {
    background: #fdf0ee; color: #c0392b; border: 1px solid #f0b8b2;
  }
  .btn-delete:hover { background: #c0392b; color: #fff; }

  /* Digital Civic ID Card Modal */
  .modal-overlay {
    display: none; position: fixed; inset: 0; background: rgba(10,25,50,0.65);
    backdrop-filter: blur(4px); z-index: 1000;
    align-items: center; justify-content: center; padding: 20px;
  }
  .modal-overlay.active { display: flex; }
  .civic-card-modal {
    background: #fff; border-radius: 16px; max-width: 440px; width: 100%;
    box-shadow: 0 12px 48px rgba(0,0,0,0.3); overflow: hidden;
    position: relative; animation: popIn 0.3s cubic-bezier(0.16, 1, 0.3, 1);
  }
  @keyframes popIn {
    from { transform: scale(0.92); opacity: 0; }
    to { transform: scale(1); opacity: 1; }
  }
  .id-card-header {
    background: linear-gradient(135deg, #1a3a6e 0%, #2558a8 100%);
    color: #fff; padding: 20px 24px; text-align: center; position: relative;
  }
  .id-card-emblem { font-size: 32px; margin-bottom: 6px; }
  .id-card-gov { font-size: 11px; text-transform: uppercase; letter-spacing: 1.5px; opacity: 0.85; font-weight: 700; }
  .id-card-title { font-size: 17px; font-weight: 800; margin-top: 2px; }
  .id-card-body { padding: 24px; }
  .id-badge-status {
    display: inline-flex; align-items: center; gap: 6px; background: #e6f4ea; color: #1e8e3e;
    font-size: 11px; font-weight: 700; padding: 4px 10px; border-radius: 20px; border: 1px solid #a8dfc0; margin-bottom: 16px;
  }
  .id-field-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; margin-bottom: 18px; text-align: left; }
  .id-field label { font-size: 10.5px; text-transform: uppercase; letter-spacing: 0.5px; color: #5a6e82; font-weight: 700; display: block; margin-bottom: 3px; }
  .id-field span { font-size: 13.5px; font-weight: 700; color: #1e2d3d; }
  .id-card-barcode {
    background: #f4f7fb; border: 1px dashed #c0d1e5; border-radius: 8px;
    padding: 10px; text-align: center; font-family: monospace; font-size: 14px; letter-spacing: 3px; color: #1a3a6e;
    margin-bottom: 18px;
  }
  .id-card-actions { display: flex; gap: 10px; justify-content: flex-end; }
  .close-modal-btn {
    position: absolute; right: 14px; top: 14px; background: rgba(255,255,255,0.2);
    border: none; color: #fff; width: 28px; height: 28px; border-radius: 50%;
    cursor: pointer; font-size: 16px; display: flex; align-items: center; justify-content: center;
  }
  .close-modal-btn:hover { background: rgba(255,255,255,0.35); }

  /* Print Stylesheet */
  @media print {
    body { background: #fff !important; }
    .navbar, .page-top, .toolbar, .footer, .btn, .search-group, .action-buttons, .metrics-grid, .breakdown-card { display: none !important; }
    .print-only-header { display: block !important; margin-bottom: 20px; border-bottom: 2px solid #1a3a6e; padding-bottom: 10px; }
    .table-card { border: none !important; box-shadow: none !important; }
    table.data-table { border: 1px solid #000; }
    table.data-table th, table.data-table td { border: 1px solid #999 !important; color: #000 !important; font-size: 11px !important; padding: 6px 10px !important; }
    table.data-table thead { background: #eee !important; color: #000 !important; }
    .loc-code { border: 1px solid #ccc; background: none !important; }
    th:last-child, td:last-child { display: none !important; }
  }
  .print-only-header { display: none; }
</style>
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
    <a href="/viewjsp" class="active">Registry & Analytics</a>
    <a href="/viewRest">REST API</a>
  </div>
</nav>

<main>
  <div class="container">

    <!-- Alert if deleted -->
    <c:if test="${not empty deletedAlert}">
      <div class="alert alert-success" style="margin-bottom:20px;display:flex;align-items:center;gap:10px;">
        <span>✅</span>
        <span><c:out value="${deletedAlert}"/></span>
      </div>
    </c:if>

    <!-- Print Only Official Header -->
    <div class="print-only-header">
      <h2 style="margin:0;font-size:18pt;color:#1a3a6e;">Government of NCT of Delhi</h2>
      <p style="margin:4px 0 0 0;font-size:11pt;color:#333;">Official Resident Registry Report &bull; Printed on: <span id="printDate"></span></p>
    </div>

    <!-- Top Banner -->
    <div class="page-top">
      <div class="page-top-text">
        <h1>📊 Civic Database & Demographic Registry</h1>
        <p>Comprehensive demographic directory, live analytics, and digital civic verification</p>
      </div>
      <div class="page-top-actions">
        <a href="/lgn" class="btn btn-outline" style="color:#fff;border-color:rgba(255,255,255,0.6);">➕ Register Resident</a>
        <a href="/viewRest" class="btn btn-outline" style="color:#fff;border-color:rgba(255,255,255,0.6);">⚙️ REST JSON</a>
      </div>
    </div>

    <!-- Analytics Metrics Grid -->
    <div class="metrics-grid">
      <div class="metric-card">
        <div class="metric-icon-box icon-blue">👥</div>
        <div class="metric-info">
          <span class="metric-val"><c:out value="${totalResidents != null ? totalResidents : 0}"/></span>
          <span class="metric-title">Total Residents</span>
        </div>
      </div>

      <div class="metric-card">
        <div class="metric-icon-box icon-green">🗺️</div>
        <div class="metric-info">
          <span class="metric-val"><c:out value="${totalStates != null ? totalStates : 0}"/></span>
          <span class="metric-title">States Covered</span>
        </div>
      </div>

      <div class="metric-card">
        <div class="metric-icon-box icon-orange">📍</div>
        <div class="metric-info">
          <span class="metric-val"><c:out value="${totalDistricts != null ? totalDistricts : 0}"/></span>
          <span class="metric-title">Districts Covered</span>
        </div>
      </div>

      <div class="metric-card">
        <div class="metric-icon-box icon-purple">🏆</div>
        <div class="metric-info">
          <span class="metric-val" style="font-size:17px;"><c:out value="${topState != null ? topState : 'None'}"/></span>
          <span class="metric-title">Top Activity State</span>
        </div>
      </div>
    </div>

    <!-- Visual Demographic Breakdown Bar -->
    <c:if test="${not empty stateBreakdown}">
      <div class="breakdown-card">
        <div class="breakdown-header">
          <span class="breakdown-title">📈 Demographic State Distribution</span>
          <span style="font-size:12px;color:#5a6e82;font-weight:600;">Based on <c:out value="${totalResidents}"/> registered records</span>
        </div>
        <div class="breakdown-bars-container">
          <c:forEach items="${stateBreakdown}" var="item">
            <div class="breakdown-row">
              <span class="breakdown-label"><c:out value="${item.stateName}"/></span>
              <div class="progress-track">
                <div class="progress-fill" style="width: ${item.percentage}%; background-color: ${item.color};"></div>
              </div>
              <span class="breakdown-stat"><c:out value="${item.count}"/> (<c:out value="${item.percentage}"/>%)</span>
            </div>
          </c:forEach>
        </div>
      </div>
    </c:if>

    <!-- Toolbar: Search + State Filter + Export + Print -->
    <div class="toolbar">
      <div class="search-group">
        <div class="search-box">
          <svg class="search-icon-svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="11" cy="11" r="8"></circle>
            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
          </svg>
          <input type="text" id="searchInput" placeholder="Search by name, state, district or phone…" oninput="applyFilters()">
        </div>

        <select id="stateFilter" class="filter-select" onchange="applyFilters()">
          <option value="">🏛️ All States</option>
          <c:forEach items="${stateList}" var="st">
            <option value="${st.stName}"><c:out value="${st.stName}"/></option>
          </c:forEach>
        </select>
      </div>

      <div class="toolbar-actions">
        <span class="row-count-badge" id="rowCount">— records</span>
        <a href="/exportCsv" class="btn btn-secondary btn-sm" title="Download Excel/CSV File">
          📥 Export CSV
        </a>
        <button type="button" class="btn btn-outline btn-sm" onclick="printReport()" title="Print Registry or Save PDF">
          🖨️ Print Report
        </button>
      </div>
    </div>

    <!-- Table Card -->
    <div class="table-card">
      <c:choose>
        <c:when test="${empty v}">
          <div class="empty-state">
            <div class="icon">📂</div>
            <h3>No Resident Records Found</h3>
            <p>The civic registry is currently empty. Start by registering residents.</p>
            <a href="/lgn" class="btn btn-primary btn-sm" style="margin-top:14px;">Go to Registration</a>
          </div>
        </c:when>
        <c:otherwise>
          <div style="overflow-x:auto;">
            <table class="data-table" id="dataTable">
              <thead>
                <tr>
                  <th style="width:85px;"># RID</th>
                  <th>State</th>
                  <th>District</th>
                  <th>Resident Name</th>
                  <th>Phone Number</th>
                  <th style="width:170px;text-align:center;">Civic Actions</th>
                </tr>
              </thead>
              <tbody id="tableBody">
                <c:forEach items="${v}" var="item">
                  <tr data-state="${stateMap[item.stCode] != null ? stateMap[item.stCode] : item.stCode}">
                    <td>
                      <span class="badge">#<c:out value="${item.rid}"/></span>
                    </td>
                    <td>
                      <div class="loc-pill">
                        <span class="state-name-text">
                          <c:choose>
                            <c:when test="${not empty stateMap[item.stCode]}">
                              <c:out value="${stateMap[item.stCode]}"/>
                            </c:when>
                            <c:otherwise>
                              State <c:out value="${item.stCode}"/>
                            </c:otherwise>
                          </c:choose>
                        </span>
                        <span class="loc-code"><c:out value="${item.stCode}"/></span>
                      </div>
                    </td>
                    <td>
                      <div class="loc-pill">
                        <span class="dist-name-text">
                          <c:choose>
                            <c:when test="${not empty distMap[item.distCode]}">
                              <c:out value="${distMap[item.distCode]}"/>
                            </c:when>
                            <c:otherwise>
                              District <c:out value="${item.distCode}"/>
                            </c:otherwise>
                          </c:choose>
                        </span>
                        <span class="loc-code"><c:out value="${item.distCode}"/></span>
                      </div>
                    </td>
                    <td>
                      <div class="resident-cell">
                        <div class="resident-avatar">
                          <c:out value="${item.name != null && item.name.length() > 0 ? item.name.substring(0,1).toUpperCase() : 'U'}"/>
                        </div>
                        <span class="resident-name-text"><c:out value="${item.name}"/></span>
                      </div>
                    </td>
                    <td>
                      <a href="tel:${item.phone}" class="phone-link">
                        📞 <span class="resident-phone-text"><c:out value="${item.phone}"/></span>
                      </a>
                    </td>
                    <td>
                      <div class="action-buttons" style="justify-content:center;">
                        <button type="button" class="btn-action btn-id-card"
                          onclick="showCivicCard('${item.rid}', '${item.name}', '${item.phone}', '${stateMap[item.stCode]}', '${distMap[item.distCode]}')"
                          title="Generate Digital Civic ID Card">
                          🪪 ID Card
                        </button>
                        <a href="/deleteResident?rid=${item.rid}" class="btn-action btn-delete"
                          onclick="return confirm('Are you sure you want to delete resident #${item.rid} (${item.name}) from the civic database?');"
                          title="Delete Record">
                          🗑️
                        </a>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

  </div>
</main>

<!-- Digital Civic ID Card Modal -->
<div class="modal-overlay" id="civicModal" onclick="closeModalOnBg(event)">
  <div class="civic-card-modal">
    <button type="button" class="close-modal-btn" onclick="closeModal()">&times;</button>
    <div class="id-card-header">
      <div class="id-card-emblem">🏛️</div>
      <div class="id-card-gov">Government of NCT of Delhi</div>
      <div class="id-card-title">Digital Civic Identity Card</div>
    </div>
    <div class="id-card-body">
      <div style="text-align:center;">
        <span class="id-badge-status">✅ Official Verified Record</span>
      </div>
      <div class="id-field-grid">
        <div class="id-field">
          <label>Civic ID (RID)</label>
          <span id="mRid">#0</span>
        </div>
        <div class="id-field">
          <label>Issue Authority</label>
          <span>NCT Delhi Civic DB</span>
        </div>
        <div class="id-field" style="grid-column: span 2;">
          <label>Full Name</label>
          <span id="mName" style="font-size:15px;color:#1a3a6e;">—</span>
        </div>
        <div class="id-field">
          <label>State</label>
          <span id="mState">—</span>
        </div>
        <div class="id-field">
          <label>District</label>
          <span id="mDistrict">—</span>
        </div>
        <div class="id-field" style="grid-column: span 2;">
          <label>Mobile Number</label>
          <span id="mPhone">📞 —</span>
        </div>
      </div>

      <div class="id-card-barcode" id="mBarcode">
        *DEL-CIVIC-00000*
      </div>

      <div class="id-card-actions">
        <button type="button" class="btn btn-outline btn-sm" onclick="closeModal()">Close</button>
        <button type="button" class="btn btn-primary btn-sm" onclick="window.print()">🖨️ Print ID</button>
      </div>
    </div>
  </div>
</div>

<footer class="footer">
  &copy; 2026 Delhi Civic Portal &nbsp;|&nbsp; Government of NCT of Delhi &nbsp;|&nbsp; Official Demographic Registry
</footer>

<script>
  function countRows() {
    var rows = document.querySelectorAll("#tableBody tr");
    var visible = 0;
    rows.forEach(function(r) {
      if (r.style.display !== 'none') visible++;
    });
    var el = document.getElementById("rowCount");
    if (el) {
      el.textContent = visible + " resident" + (visible === 1 ? "" : "s");
    }
  }

  function applyFilters() {
    var search = document.getElementById("searchInput").value.toLowerCase().trim();
    var state = document.getElementById("stateFilter").value.toLowerCase().trim();
    var rows = document.querySelectorAll("#tableBody tr");

    rows.forEach(function(row) {
      var rowState = (row.getAttribute("data-state") || "").toLowerCase();
      var text = row.textContent.toLowerCase();

      var matchesSearch = !search || text.indexOf(search) !== -1;
      var matchesState = !state || rowState.indexOf(state) !== -1;

      row.style.display = (matchesSearch && matchesState) ? "" : "none";
    });
    countRows();
  }

  function showCivicCard(rid, name, phone, state, dist) {
    document.getElementById("mRid").textContent = "#DEL-" + String(rid).padStart(5, '0');
    document.getElementById("mName").textContent = name || "—";
    document.getElementById("mPhone").textContent = "📞 " + (phone || "—");
    document.getElementById("mState").textContent = state || "Delhi";
    document.getElementById("mDistrict").textContent = dist || "—";
    document.getElementById("mBarcode").textContent = "*DELHI-CIVIC-RID-" + rid + "*";
    document.getElementById("civicModal").classList.add("active");
  }

  function closeModal() {
    document.getElementById("civicModal").classList.remove("active");
  }

  function closeModalOnBg(e) {
    if (e.target.id === "civicModal") {
      closeModal();
    }
  }

  function printReport() {
    var d = new Date();
    var pEl = document.getElementById("printDate");
    if (pEl) pEl.textContent = d.toLocaleString();
    window.print();
  }

  window.addEventListener('DOMContentLoaded', countRows);
</script>

</body>
</html>
