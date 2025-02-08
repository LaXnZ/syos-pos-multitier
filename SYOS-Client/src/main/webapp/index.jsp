<%--
  Created by IntelliJ IDEA.
  User: sumuditha
  Date: 2025-02-04
  Time: 14:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SYOS Store</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/styles/index.css">
</head>
<body class="bg-gray-100">

<!-- Header Section -->
<header class="bg-blue-600 p-6 text-white text-center">
    <h1 class="text-3xl font-bold">Welcome to SYOS Store</h1>
    <p class="text-lg">Your one-stop shop for all things amazing!</p>
</header>

<!-- Hero Section -->
<section class="bg-white p-8">
    <div class="text-center">
        <h2 class="text-2xl font-semibold mb-4">Explore Our Categories</h2>
        <p class="mb-6 text-gray-700">We offer a wide variety of products. Choose your category and start shopping!</p>

        <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-6">
            <!-- Product Categories -->
            <div class="bg-gray-200 p-4 rounded-lg text-center hover:bg-blue-100">
                <img src="https://via.placeholder.com/150" alt="Fruits" class="mx-auto mb-3">
                <h3 class="font-semibold text-lg">Fruits</h3>
            </div>
            <div class="bg-gray-200 p-4 rounded-lg text-center hover:bg-blue-100">
                <img src="https://via.placeholder.com/150" alt="Vegetables" class="mx-auto mb-3">
                <h3 class="font-semibold text-lg">Vegetables</h3>
            </div>
            <div class="bg-gray-200 p-4 rounded-lg text-center hover:bg-blue-100">
                <img src="https://via.placeholder.com/150" alt="Dairy" class="mx-auto mb-3">
                <h3 class="font-semibold text-lg">Dairy</h3>
            </div>
            <div class="bg-gray-200 p-4 rounded-lg text-center hover:bg-blue-100">
                <img src="https://via.placeholder.com/150" alt="Snacks" class="mx-auto mb-3">
                <h3 class="font-semibold text-lg">Snacks</h3>
            </div>
        </div>
    </div>
</section>

<!-- Featured Products Section -->
<section class="bg-gray-50 p-8">
    <div class="text-center">
        <h2 class="text-2xl font-semibold mb-4">Featured Products</h2>
        <p class="mb-6 text-gray-700">Check out some of our best-selling products this month!</p>

        <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-6">
            <!-- Product Cards (Static Content for now) -->
            <div class="bg-white p-4 rounded-lg shadow-md hover:shadow-lg transition-all">
                <img src="https://via.placeholder.com/150" alt="Product 1" class="mb-4 mx-auto">
                <h3 class="font-semibold text-lg">Fresh Apples</h3>
                <p class="text-gray-600">$5.99</p>
                <button class="bg-blue-600 text-white py-2 px-4 mt-4 rounded-lg w-full">Add to Cart</button>
            </div>
            <div class="bg-white p-4 rounded-lg shadow-md hover:shadow-lg transition-all">
                <img src="https://via.placeholder.com/150" alt="Product 2" class="mb-4 mx-auto">
                <h3 class="font-semibold text-lg">Organic Carrots</h3>
                <p class="text-gray-600">$3.49</p>
                <button class="bg-blue-600 text-white py-2 px-4 mt-4 rounded-lg w-full">Add to Cart</button>
            </div>
            <div class="bg-white p-4 rounded-lg shadow-md hover:shadow-lg transition-all">
                <img src="https://via.placeholder.com/150" alt="Product 3" class="mb-4 mx-auto">
                <h3 class="font-semibold text-lg">Low-Fat Milk</h3>
                <p class="text-gray-600">$2.99</p>
                <button class="bg-blue-600 text-white py-2 px-4 mt-4 rounded-lg w-full">Add to Cart</button>
            </div>
            <div class="bg-white p-4 rounded-lg shadow-md hover:shadow-lg transition-all">
                <img src="https://via.placeholder.com/150" alt="Product 4" class="mb-4 mx-auto">
                <h3 class="font-semibold text-lg">Chocolates</h3>
                <p class="text-gray-600">$7.99</p>
                <button class="bg-blue-600 text-white py-2 px-4 mt-4 rounded-lg w-full">Add to Cart</button>
            </div>
        </div>
    </div>
</section>

<!-- Login/Register Section -->
<section class="text-center py-8">
    <p class="text-lg">Already have an account?</p>
    <a href="login.jsp" class="bg-green-600 text-white py-2 px-6 rounded-lg mr-4">Login</a>
    <p class="text-lg">New to SYOS Store?</p>
    <a href="register.jsp" class="bg-blue-600 text-white py-2 px-6 rounded-lg">Register</a>
</section>

<!-- Footer Section -->
<footer class="bg-blue-600 text-white text-center p-4 mt-8">
    <p>&copy; 2025 SYOS Store. All Rights Reserved.</p>
</footer>

</body>
</html>

