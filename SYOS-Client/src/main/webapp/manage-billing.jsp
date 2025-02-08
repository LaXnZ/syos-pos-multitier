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
    <title>Manage Billing - Admin</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/styles/manage-billing.css">
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

        // Function to create a new bill for a customer
        async function createBill() {
            const customerPhone = document.getElementById("customerPhone").value;
            if (!customerPhone) {
                alert("Please enter the customer phone number.");
                return;
            }

            try {
                const response = await fetch("http://localhost:8080/SYOS-Server/api/billing/create", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({ phoneNumber: customerPhone })
                });

                const result = await response.json();
                if (response.ok) {
                    alert(result.message || "Bill created successfully!");
                    document.getElementById("billId").value = result.billId;  // Set the Bill ID in the form
                    showBillSection();
                } else {
                    alert(result.error || "Failed to create bill.");
                }
            } catch (error) {
                console.error("Error creating bill:", error);
            }
        }

        // Function to add an item to the bill
        async function addItemToBill() {
            const billId = document.getElementById("billId").value;
            const itemCode = document.getElementById("itemCode").value;
            const quantity = document.getElementById("itemQuantity").value;

            if (!billId || !itemCode || !quantity) {
                alert("Please enter all item details.");
                return;
            }

            try {
                const response = await fetch(`http://localhost:8080/SYOS-Server/api/billing/addItem/${billId}?quantity=${quantity}`, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({ itemCode: itemCode })
                });

                const result = await response.json();
                if (response.ok) {
                    alert(result.message || "Item added to the bill.");
                    // Optionally, you can refresh the bill details here
                } else {
                    alert(result.error || "Failed to add item.");
                }
            } catch (error) {
                console.error("Error adding item:", error);
            }
        }

        // Function to apply discount to the bill
        async function applyDiscount() {
            const billId = document.getElementById("billId").value;
            const discountRate = document.getElementById("discountRate").value;

            if (!billId || !discountRate) {
                alert("Please enter discount rate.");
                return;
            }

            try {
                const response = await fetch(`http://localhost:8080/SYOS-Server/api/billing/applyDiscount/${billId}?discountRate=${discountRate}`, {
                    method: "POST"
                });

                const result = await response.json();
                if (response.ok) {
                    alert(result.message || "Discount applied.");
                } else {
                    alert(result.error || "Failed to apply discount.");
                }
            } catch (error) {
                console.error("Error applying discount:", error);
            }
        }

        // Function to finalize the bill (process payment)
        async function finalizeBill() {
            const billId = document.getElementById("billId").value;
            const cashTendered = document.getElementById("cashTendered").value;
            const useLoyalty = document.getElementById("useLoyalty").checked;

            if (!billId || !cashTendered) {
                alert("Please enter cash tendered.");
                return;
            }

            try {
                const response = await fetch(`http://localhost:8080/SYOS-Server/api/billing/finalize/${billId}?cash=${cashTendered}&useLoyalty=${useLoyalty}`, {
                    method: "POST"
                });

                const result = await response.json();
                if (response.ok) {
                    alert(result.message || "Bill finalized successfully.");
                } else {
                    alert(result.error || "Failed to finalize bill.");
                }
            } catch (error) {
                console.error("Error finalizing bill:", error);
            }
        }

        // Show the bill section after bill is created
        function showBillSection() {
            document.getElementById("billSection").style.display = "block";
        }

        function logout() {
            sessionStorage.clear();
            window.location.href = "login.jsp";
        }
    </script>
</head>
<body>
<header>
    <h1>Manage Billing</h1>
    <div class="user-info">
        <span id="admin-name"></span>
        <button onclick="logout()">Logout</button>
    </div>
</header>

<main class="container">
    <a href="admin-dashboard.jsp" class="back-btn">⬅️ Back to Dashboard</a>

    <h3>Create New Bill</h3>
    <form onsubmit="createBill(); return false;">
        <input type="text" id="customerPhone" placeholder="Enter customer phone number" required>
        <button type="submit">Create Bill</button>
    </form>

    <div id="billSection" style="display:none;">
        <h3>Bill Details</h3>
        <input type="hidden" id="billId">

        <h4>Add Item to Bill</h4>
        <input type="text" id="itemCode" placeholder="Item Code" required>
        <input type="number" id="itemQuantity" placeholder="Quantity" required>
        <button onclick="addItemToBill()">Add Item</button>

        <h4>Apply Discount</h4>
        <input type="number" id="discountRate" placeholder="Discount Rate (%)" required>
        <button onclick="applyDiscount()">Apply Discount</button>

        <h4>Finalize Bill</h4>
        <input type="number" id="cashTendered" placeholder="Cash Tendered" required>
        <label>
            <input type="checkbox" id="useLoyalty"> Use Loyalty Points
        </label>
        <button onclick="finalizeBill()">Finalize Bill</button>
    </div>
</main>
</body>
</html>

