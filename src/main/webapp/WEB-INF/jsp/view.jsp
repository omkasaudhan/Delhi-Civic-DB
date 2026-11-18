<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Resident Records & Analytics — Delhi Civic Portal</title>
<link rel="stylesheet" href="/css/style.css">
<style>
  body { display: flex; flex-direction: column; min-height: 100vh; background: #f0f4f8; }
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
    margin-bottom: 24px;
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

  /* Search & Actions Toolbar */
  .toolbar {
    background: #fff;
    border-radius: 12px;
    padding: 16px 20px;
    margin-bottom: 18px;
    border: 1px solid #e1e8f0;
    box-shadow: 0 2px 12px rgba(26,58,110,0.05);
    display: flex; align-items: center; justify-content: space-between;
    gap: 16px; flex-wrap: wrap;
  }
  .search-box {
    position: relative;
    flex: 1; max-width: 380px; min-width: 240px;
  }
  .search-box input {
    width: 100%;
    padding: 10px 14px 10px 38px;
    border: 1.5px solid #d1dbe6;
    border-radius: 8px; font-size: 14px;
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

  .toolbar-actions {
    display: flex; align-items: center; gap: 10px; flex-wrap: wrap; margin-left: auto;
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
    padding: 14px 18px;
    font-size: 12px; font-weight: 700;
    letter-spacing: 0.6px; text-transform: uppercase;
  }
  table.data-table tbody tr {
    border-bottom: 1px solid #e8eff6;
    transition: background 0.15s;
  }
  table.data-table tbody tr:hover { background: #f6f9fc; }
  table.data-table td {
    padding: 13px 18px;
    font-size: 14px;
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
  }
  .phone-link {
    color: #1a73e8; text-decoration: none; font-weight: 500;
    display: inline-flex; align-items: center; gap: 5px;
  }
  .phone-link:hover { text-decoration: underline; }

  /* Empty state */
  .empty-state {
    text-align: center; padding: 50px 20px; color: #5a6e82;
  }
  .empty-state .icon { font-size: 42px; margin-bottom: 12px; }

  /* Print Stylesheet */
  @media print {
    body { background: #fff !important; }
    .navbar, .page-top, .toolbar, .footer, .btn, .search-box { display: none !important; }
    .print-only-header { display: block !important; margin-bottom: 20px; border-bottom: 2px solid #1a3a6e; padding-bottom: 10px; }
    .table-card { border: none !important; box-shadow: none !important; }
    table.data-table { border: 1px solid #000; }
    table.data-table th, table.data-table td { border: 1px solid #999 !important; color: #000 !important; font-size: 12px !important; padding: 8px !important; }
    table.data-table thead { background: #eee !important; color: #000 !important; }
    .loc-code { border: 1px solid #ccc; background: none !important; }
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

    <!-- Print Only Official Header -->
    <div class="print-only-header">
      <h2 style="margin:0;font-size:18pt;color:#1a3a6e;">Government of NCT of Delhi</h2>
      <p style="margin:4px 0 0 0;font-size:11pt;color:#333;">Official Resident Registry Report &bull; Printed on: <span id="printDate"></span></p>
    </div>

    <!-- Top Banner -->
    <div class="page-top">
      <div class="page-top-text">
        <h1>📊 Resident Registry & Analytics</h1>
        <p>Comprehensive civic database and real-time demographic metrics</p>
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

    <!-- Toolbar: Search + Export to CSV + Print -->
    <div class="toolbar">
      <div class="search-box">
        <svg class="search-icon-svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <circle cx="11" cy="11" r="8"></circle>
          <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
        </svg>
        <input type="text" id="searchInput" placeholder="Search by name, state, district or phone…" oninput="filterTable()">
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
                  <th style="width:90px;"># RID</th>
                  <th>State</th>
                  <th>District</th>
                  <th>Resident Name</th>
                  <th>Phone Number</th>
                </tr>
              </thead>
              <tbody id="tableBody">
                <c:forEach items="${v}" var="item">
                  <tr>
                    <td>
                      <span class="badge">#<c:out value="${item.rid}"/></span>
                    </td>
                    <td>
                      <div class="loc-pill">
                        <span>
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
                        <span>
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
                        <span><c:out value="${item.name}"/></span>
                      </div>
                    </td>
                    <td>
                      <a href="tel:${item.phone}" class="phone-link">
                        📞 <c:out value="${item.phone}"/>
                      </a>
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

  function filterTable() {
    var q = document.getElementById("searchInput").value.toLowerCase().trim();
    var rows = document.querySelectorAll("#tableBody tr");
    rows.forEach(function(row) {
      var text = row.textContent.toLowerCase();
      row.style.display = text.indexOf(q) !== -1 ? "" : "none";
    });
    countRows();
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
