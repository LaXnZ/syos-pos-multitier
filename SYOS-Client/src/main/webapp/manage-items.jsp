<%--
  Created by IntelliJ IDEA.
  User: sumuditha
  Date: 2025-02-07
  Time: 23:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Items - Admin</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/styles/manage-items.css">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            checkAdminAccess();
            fetchItemList();  // Fetch the list of item IDs first
        });

        function checkAdminAccess() {
            const role = sessionStorage.getItem("role");
            if (!role || role !== "ADMIN") {
                sessionStorage.clear();
                window.location.href = "login.jsp";
            }

            document.getElementById("admin-name").innerText = sessionStorage.getItem("name") || "Admin";
        }

        async function fetchItemList() {
            try {
                const response = await fetch("http://localhost:8080/SYOS-Server/api/items");
                const items = await response.json();

                if (Array.isArray(items) && items.length > 0) {
                    items.forEach(item => {
                        const itemId = item.itemId;

                        // Ensure itemId is valid (non-null and positive integer)
                        if (itemId && itemId > 0) {
                            console.log("Valid Item ID:", itemId);
                            fetchItemDetails(itemId);  // Fetch each item by itemId
                        } else {
                            console.error("Invalid or missing itemId:", itemId);
                        }
                    });
                } else {
                    console.error("No items found or invalid data structure");
                }
            } catch (error) {
                console.error("Error fetching items list:", error);
            }
        }

        async function fetchItemDetails(itemId) {
            try {
                console.log("Fetching details for itemId:", itemId);  // Log the itemId being fetched
                const response = await fetch(`http://localhost:8080/SYOS-Server/api/items/${itemId}`);
                const item = await response.json();

                if (item && item.itemId) {
                    displayItem(item);  // Display the item in the table
                } else {
                    console.error(`Item with ID ${itemId} not found`);
                }
            } catch (error) {
                console.error(`Error fetching item with ID ${itemId}:`, error);
            }
        }



        function displayItem(item) {
            const tableBody = document.getElementById("items-table-body");
            const row = document.createElement("tr");

            row.innerHTML = `
                <td>${item.itemCode}</td>
                <td>${item.itemName}</td>
                <td>$${item.itemPrice}</td>
                <td>
                    <button class="edit-btn" onclick="editItem(${item.itemId}, '${item.itemCode}', '${item.itemName}', ${item.itemPrice})">✏️ Edit</button>
                    <button class="delete-btn" onclick="deleteItem(${item.itemId})">❌ Delete</button>
                </td>
            `;
            // Append the new row to the table body
            tableBody.appendChild(row);
        }

        async function deleteItem(itemId) {
            if (!confirm("Are you sure you want to delete this item?")) return;
            try {
                const response = await fetch(`http://localhost:8080/SYOS-Server/api/items/${itemId}`, { method: "DELETE" });
                const result = await response.json();
                alert(result.message || result);
                fetchItemList(); // Refresh the list after deletion
            } catch (error) {
                console.error("Error deleting item:", error);
            }
        }

        function editItem(itemId, itemCode, itemName, itemPrice) {
            document.getElementById("updateItemId").value = itemId;
            document.getElementById("updateItemCode").value = itemCode;
            document.getElementById("updateItemName").value = itemName;
            document.getElementById("updateItemPrice").value = itemPrice;
            document.getElementById("editForm").style.display = "block";
        }

        async function addItem(event) {
            event.preventDefault();
            const itemCode = document.getElementById("itemCode").value;
            const itemName = document.getElementById("itemName").value;
            const itemPrice = document.getElementById("itemPrice").value;

            const response = await fetch("http://localhost:8080/SYOS-Server/api/items", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ itemCode, itemName, itemPrice })
            });

            const result = await response.json();
            alert(result.message || result);
            fetchItemList(); // Refresh the items list
        }

        async function updateItem(event) {
            event.preventDefault();
            const itemId = document.getElementById("updateItemId").value;
            const itemCode = document.getElementById("updateItemCode").value;
            const itemName = document.getElementById("updateItemName").value;
            const itemPrice = document.getElementById("updateItemPrice").value;

            const response = await fetch(`http://localhost:8080/SYOS-Server/api/items/${itemId}`, {
                method: "PUT",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ itemId, itemCode, itemName, itemPrice })
            });

            const result = await response.json();
            alert(result.message || result);
            document.getElementById("editForm").style.display = "none";
            fetchItemList(); // Refresh the items list
        }

        function logout() {
            sessionStorage.clear();
            window.location.href = "login.jsp";
        }

    </script>
</head>
<body>
<header>
    <h1>Manage Items</h1>
    <div class="user-info">
        <span id="admin-name"></span>
        <button onclick="logout()">Logout</button>
    </div>
</header>

<main class="container">
    <a href="admin-dashboard.jsp" class="back-btn">⬅️ Back to Dashboard</a>

    <h3>Add New Item</h3>
    <form onsubmit="addItem(event)">
        <input type="text" id="itemCode" placeholder="Item Code" required>
        <input type="text" id="itemName" placeholder="Item Name" required>
        <input type="number" id="itemPrice" placeholder="Price" required>
        <button type="submit">Add Item</button>
    </form>

    <h3>Edit Item</h3>
    <form id="editForm" style="display:none;" onsubmit="updateItem(event)">
        <input type="hidden" id="updateItemId">
        <input type="text" id="updateItemCode" required>
        <input type="text" id="updateItemName" required>
        <input type="number" id="updateItemPrice" required>
        <button type="submit">Update Item</button>
    </form>

    <h2>Items List</h2>
    <div id="items-container" class="manage-container">
        <table>
            <thead>
            <tr>
                <th>Item Code</th>
                <th>Item Name</th>
                <th>Item Price</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="items-table-body">
            <!-- Table rows will be dynamically added here -->
            </tbody>
        </table>
    </div>
</main>
</body>
</html>

