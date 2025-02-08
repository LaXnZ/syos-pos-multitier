<%--
  Created by IntelliJ IDEA.
  User: sumuditha
  Date: 2025-02-07
  Time: 23:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Stocks - Admin</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/styles/manage-stock.css">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            checkAdminAccess();
            fetchAllStocks();  // Fetch all stocks when the page loads
        });

        function checkAdminAccess() {
            const role = sessionStorage.getItem("role");
            if (!role || role !== "ADMIN") {
                sessionStorage.clear();
                window.location.href = "login.jsp";
            }

            document.getElementById("admin-name").innerText = sessionStorage.getItem("name") || "Admin";
        }

        async function fetchAllStocks() {
            try {
                const response = await fetch("http://localhost:8080/SYOS-Server/api/stocks");
                const stocks = await response.json();

                if (Array.isArray(stocks) && stocks.length > 0) {
                    displayStocks(stocks);
                } else {
                    console.error("No stocks found or invalid data structure");
                }
            } catch (error) {
                console.error("Error fetching stocks:", error);
            }
        }

        function displayStocks(stocks) {
            const tableBody = document.getElementById("stocks-table-body");
            tableBody.innerHTML = "";

            stocks.forEach(stock => {
                const row = document.createElement("tr");

                row.innerHTML = `
                    <td>${stock.batchCode}</td>
                    <td>${stock.itemCode}</td>
                    <td>${stock.quantityInStock}</td>
                    <td>${stock.shelfCapacity}</td>
                    <td>${stock.purchaseDate}</td>
                    <td>${stock.expiryDate}</td>
                    <td>${stock.stockLocation}</td>
                    <td>
                        <button class="edit-btn" onclick="editStock('${stock.batchCode}')">✏️ Edit</button>
                        <button class="delete-btn" onclick="deleteStock('${stock.batchCode}')">❌ Delete</button>
                    </td>
                `;
                tableBody.appendChild(row);
            });
        }

        async function deleteStock(batchCode) {
            if (!confirm("Are you sure you want to delete this stock?")) return;
            try {
                const response = await fetch(`http://localhost:8080/SYOS-Server/api/stocks/${batchCode}`, { method: "DELETE" });
                const result = await response.json();
                alert(result.message || result.error);
                fetchAllStocks(); // Refresh the list after deletion
            } catch (error) {
                console.error("Error deleting stock:", error);
            }
        }

        function editStock(batchCode) {
            window.location.href = `edit-stock.jsp?batchCode=${batchCode}`;
        }

        async function addStock(event) {
            event.preventDefault();
            const batchCode = document.getElementById("batchCode").value;
            const itemCode = document.getElementById("itemCode").value;
            const quantityInStock = document.getElementById("quantityInStock").value;
            const shelfCapacity = document.getElementById("shelfCapacity").value;
            const purchaseDate = document.getElementById("purchaseDate").value;
            const expiryDate = document.getElementById("expiryDate").value;
            const stockLocation = document.getElementById("stockLocation").value;

            const newStock = {
                batchCode,
                itemCode,
                quantityInStock,
                shelfCapacity,
                purchaseDate,
                expiryDate,
                stockLocation
            };

            try {
                const response = await fetch("http://localhost:8080/SYOS-Server/api/stocks", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify(newStock)
                });

                const result = await response.json();
                alert(result.message || result.error);
                fetchAllStocks(); // Refresh the stock list after adding
            } catch (error) {
                console.error("Error adding stock:", error);
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
    <h1>Manage Stocks</h1>
    <div class="user-info">
        <span id="admin-name"></span>
        <button onclick="logout()">Logout</button>
    </div>
</header>

<main class="container">
    <a href="admin-dashboard.jsp" class="back-btn">⬅️ Back to Dashboard</a>

    <h3>Add New Stock</h3>
    <form onsubmit="addStock(event)">
        <input type="text" id="batchCode" placeholder="Batch Code" required>
        <input type="text" id="itemCode" placeholder="Item Code" required>
        <input type="number" id="quantityInStock" placeholder="Quantity in Stock" required>
        <input type="number" id="shelfCapacity" placeholder="Shelf Capacity" required>
        <input type="date" id="purchaseDate" placeholder="Purchase Date" required>
        <input type="date" id="expiryDate" placeholder="Expiry Date" required>
        <input type="text" id="stockLocation" placeholder="Stock Location" required>
        <button type="submit">Add Stock</button>
    </form>

    <h2>Stocks List</h2>
    <div id="stocks-container" class="manage-container">
        <table>
            <thead>
            <tr>
                <th>Batch Code</th>
                <th>Item Code</th>
                <th>Quantity</th>
                <th>Shelf Capacity</th>
                <th>Purchase Date</th>
                <th>Expiry Date</th>
                <th>Stock Location</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="stocks-table-body">
            <!-- Table rows will be dynamically added here -->
            </tbody>
        </table>
    </div>
</main>
</body>
</html>

