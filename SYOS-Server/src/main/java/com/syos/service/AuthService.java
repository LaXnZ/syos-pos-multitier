package com.syos.service;

import com.syos.config.ConnectionPool;
import com.syos.dao.CustomerDAOImpl;
import com.syos.dao.UserDAO;
import com.syos.dao.UserDAOImpl;
import com.syos.model.Admin;
import com.syos.model.User;
import com.syos.utils.JwtUtil;
import com.syos.utils.PasswordHasher;
import com.syos.model.Customer;
import com.syos.dao.CustomerDAO;

import javax.json.Json;
import javax.json.JsonObject;
import java.sql.Connection;
import java.time.LocalDate;

public class AuthService {
    private final UserDAO userDAO = new UserDAOImpl();
    private final CustomerDAO customerDAO = new CustomerDAOImpl();

    public String registerUser(User user) {
        try (Connection connection = ConnectionPool.getConnection()) {
            if (userDAO.findByEmail(user.getEmail(), connection) != null) {
                return "❌ User already exists!";
            }

            // ✅ Hash the password before storing it
            user.setPasswordHash(PasswordHasher.hashPassword(user.getPasswordHash()));

            // ✅ Save user and get generated user_id
            int userId = userDAO.saveUser(user, connection);
            if (userId == -1) return "❌ Failed to create user!";

            // ✅ If the user is a customer, add them to the customer table
            if ("CUSTOMER".equals(user.getRole())) {
                Customer customer = new Customer(userId, user.getName(), user.getEmail(), user.getPasswordHash(), "0112345678", LocalDate.now());
                customerDAO.save(customer, connection); // ✅ Save customer with user_id
            }

            return "✅ User registered successfully!";
        } catch (Exception e) {
            return "❌ Registration failed: " + e.getMessage();
        }
    }

    public JsonObject login(String email, String password) {
        try (Connection connection = ConnectionPool.getConnection()) {
            User user = userDAO.findByEmail(email, connection);
            if (user == null || !PasswordHasher.checkPassword(password, user.getPasswordHash())) {
                return Json.createObjectBuilder()
                        .add("error", "❌ Invalid credentials!")
                        .build();
            }

            String token = JwtUtil.generateToken(email, user.getRole());

            return Json.createObjectBuilder()
                    .add("token", token)
                    .add("role", user.getRole())
                    .build();
        } catch (Exception e) {
            return Json.createObjectBuilder()
                    .add("error", "❌ Login failed: " + e.getMessage())
                    .build();
        }
    }

    public boolean validateToken(String token) {
        return JwtUtil.validateToken(token);
    }
}
