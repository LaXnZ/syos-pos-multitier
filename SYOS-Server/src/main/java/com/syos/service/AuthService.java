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

    public JsonObject registerUser(User user) {
        try (Connection connection = ConnectionPool.getConnection()) {
            if (userDAO.findByEmail(user.getEmail(), connection) != null) {
                return Json.createObjectBuilder()
                        .add("error", "❌ User already exists!")
                        .build();
            }

            System.out.println("🔍 Before Hashing: " + user.getPasswordHash());

            String hashedPassword = PasswordHasher.hashPassword(user.getPasswordHash());
            user.setPasswordHash(hashedPassword);

            System.out.println("🔍 Hashed Password: " + hashedPassword);

            int userId = userDAO.saveUser(user, connection);
            if (userId == -1) return Json.createObjectBuilder().add("error", "❌ Failed to create user!").build();

            // ✅ Only insert customers, do not insert admins
            Customer customer = new Customer(userId, user.getName(), user.getEmail(), "0112345678", LocalDate.now());
            customerDAO.save(customer, connection);

            return Json.createObjectBuilder()
                    .add("message", "✅ User registered successfully!")
                    .build();
        } catch (Exception e) {
            return Json.createObjectBuilder()
                    .add("error", "❌ Registration failed: " + e.getMessage())
                    .build();
        }
    }


    public JsonObject login(String email, String password) {
        try (Connection connection = ConnectionPool.getConnection()) {
            User user = userDAO.findByEmail(email, connection);
            if (user == null) {
                return Json.createObjectBuilder()
                        .add("error", "❌ Invalid credentials! User not found.")
                        .build();
            }

            System.out.println("🔍 Entered Password: [" + password + "]");
            System.out.println("🔍 Stored Hash: [" + user.getPasswordHash() + "]");

            boolean passwordMatches = PasswordHasher.checkPassword(password, user.getPasswordHash().trim());
            System.out.println("✅ Password Match Result: " + passwordMatches);

            if (!passwordMatches) {
                return Json.createObjectBuilder()
                        .add("error", "❌ Invalid credentials! Incorrect password.")
                        .build();
            }

            String token = JwtUtil.generateToken(email, user.getRole());

            return Json.createObjectBuilder()
                    .add("token", token)
                    .add("role", user.getRole())
                    .add("name", user.getName())
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
