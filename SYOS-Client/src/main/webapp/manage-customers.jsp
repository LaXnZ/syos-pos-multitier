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
    <title>Manage Customers - Admin</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/styles/manage-customers.css">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            checkAdminAccess();
            fetchCustomers(); // Fetch all customers when the page loads
        });

        function checkAdminAccess() {
            const role = sessionStorage.getItem("role");
            if (!role || role !== "ADMIN") {
                sessionStorage.clear();
                window.location.href = "login.jsp";
            }

            document.getElementById("admin-name").innerText = sessionStorage.getItem("name") || "Admin";
        }

        async function fetchCustomers() {
            try {
                const response = await fetch("http://localhost:8080/SYOS-Server/api/customers");
                const customers = await response.json();

                if (Array.isArray(customers) && customers.length > 0) {
                    displayCustomers(customers);
                } else {
                    console.error("No customers found or invalid data structure");
                }
            } catch (error) {
                console.error("Error fetching customers:", error);
            }
        }

        function displayCustomers(customers) {
            const tableBody = document.getElementById("customers-table-body");
            tableBody.innerHTML = "";

            customers.forEach(customer => {
                const row = document.createElement("tr");

                row.innerHTML = `
                    <td>${customer.customerId}</td>
                    <td>${customer.name}</td>
                    <td>${customer.phoneNumber}</td>
                    <td>${customer.email}</td>
                    <td>
                        <button class="edit-btn" onclick="editCustomer(${customer.customerId}, '${customer.name}', '${customer.phoneNumber}', '${customer.email}')">✏️ Edit</button>
                        <button class="delete-btn" onclick="deleteCustomer(${customer.customerId})">❌ Delete</button>
                    </td>
                `;
                tableBody.appendChild(row);
            });
        }

        async function deleteCustomer(customerId) {
            if (!confirm("Are you sure you want to delete this customer?")) return;
            try {
                const response = await fetch(`http://localhost:8080/SYOS-Server/api/customers/${customerId}`, { method: "DELETE" });
                const result = await response.json();
                alert(result.message || result);
                fetchCustomers(); // Refresh the list after deletion
            } catch (error) {
                console.error("Error deleting customer:", error);
            }
        }

        function editCustomer(customerId, name, phoneNumber, email) {
            document.getElementById("updateCustomerId").value = customerId;
            document.getElementById("updateCustomerName").value = name;
            document.getElementById("updateCustomerPhone").value = phoneNumber;
            document.getElementById("updateCustomerEmail").value = email;
            document.getElementById("editForm").style.display = "block";
        }

        async function addCustomer(event) {
            event.preventDefault();
            const name = document.getElementById("customerName").value;
            const phoneNumber = document.getElementById("customerPhone").value;
            const email = document.getElementById("customerEmail").value;

            const response = await fetch("http://localhost:8080/SYOS-Server/api/customers", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ name, phoneNumber, email })
            });

            const result = await response.json();
            alert(result.message || result);
            fetchCustomers(); // Refresh the items list
        }

        async function updateCustomer(event) {
            event.preventDefault();
            const customerId = document.getElementById("updateCustomerId").value;
            const name = document.getElementById("updateCustomerName").value;
            const phoneNumber = document.getElementById("updateCustomerPhone").value;
            const email = document.getElementById("updateCustomerEmail").value;

            const response = await fetch(`http://localhost:8080/SYOS-Server/api/customers/${customerId}`, {
                method: "PUT",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ customerId, name, phoneNumber, email })
            });

            const result = await response.json();
            alert(result.message || result);
            document.getElementById("editForm").style.display = "none";
            fetchCustomers(); // Refresh the items list
        }

        function logout() {
            sessionStorage.clear();
            window.location.href = "login.jsp";
        }

    </script>
</head>
<body>
<header>
    <h1>Manage Customers</h1>
    <div class="user-info">
        <span id="admin-name"></span>
        <button onclick="logout()">Logout</button>
    </div>
</header>

<main class="container">
    <a href="admin-dashboard.jsp" class="back-btn">⬅️ Back to Dashboard</a>

    <h3>Add New Customer</h3>
    <form onsubmit="addCustomer(event)">
        <input type="text" id="customerName" placeholder="Customer Name" required>
        <input type="text" id="customerPhone" placeholder="Phone Number" required>
        <input type="email" id="customerEmail" placeholder="Email" required>
        <button type="submit">Add Customer</button>
    </form>

    <h3>Edit Customer</h3>
    <form id="editForm" style="display:none;" onsubmit="updateCustomer(event)">
        <input type="hidden" id="updateCustomerId">
        <input type="text" id="updateCustomerName" required>
        <input type="text" id="updateCustomerPhone" required>
        <input type="email" id="updateCustomerEmail" required>
        <button type="submit">Update Customer</button>
    </form>

    <h2>Customers List</h2>
    <div id="customers-container" class="manage-container">
        <table>
            <thead>
            <tr>
                <th>Customer ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="customers-table-body">
            <!-- Table rows will be dynamically added here -->
            </tbody>
        </table>
    </div>
</main>
</body>
</html>
