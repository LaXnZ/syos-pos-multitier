<%--
  Created by IntelliJ IDEA.
  User: sumuditha
  Date: 2025-02-07
  Time: 23:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Reports - Admin</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/styles/manage-reports.css">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            checkAdminAccess();
        });

        function checkAdminAccess() {
            const role = sessionStorage.getItem("role");
            if (!role || role !== "ADMIN") {
                sessionStorage.clear();
                window.location.href = "login.jsp";
            }

            document.getElementById("admin-name").innerText = sessionStorage.getItem("name") || "Admin";
        }

        async function generateReport(reportType) {
            const date = document.getElementById("reportDate").value;
            if (!date) {
                alert("Please select a date for the report.");
                return;
            }

            try {
                const response = await fetch(`http://localhost:8080/SYOS-Server/api/reports/${reportType}?date=${date}`);
                const result = await response.json();
                alert(result.message || result.error);
            } catch (error) {
                console.error("Error generating report:", error);
                alert("Error generating the report. Please try again.");
            }
        }

        function logout() {
            sessionStorage.clear();
            window.location.href = "login.jsp";
        }
    </script>
</head>
<body>
<header>
    <h1>Manage Reports</h1>
    <div class="user-info">
        <span id="admin-name"></span>
        <button onclick="logout()">Logout</button>
    </div>
</header>

<main class="container">
    <a href="admin-dashboard.jsp" class="back-btn">⬅️ Back to Dashboard</a>

    <h3>Generate Report</h3>

    <div class="report-options">
        <label for="reportDate">Select Date:</label>
        <input type="date" id="reportDate" required>

        <div class="report-buttons">
            <button onclick="generateReport('sales')">Generate Total Sales Report</button>
            <button onclick="generateReport('reshelving')">Generate Reshelving Report</button>
            <button onclick="generateReport('reorder-level')">Generate Reorder Level Report</button>
            <button onclick="generateReport('stock')">Generate Stock Report</button>
            <button onclick="generateReport('bill')">Generate Bill Report</button>
        </div>
    </div>
</main>
</body>
</html>

