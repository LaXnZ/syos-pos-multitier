package com.syos.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.Date;
import java.util.Base64;
import java.util.Optional;

public class JwtUtil {
    private static final String SECRET_KEY = "secret";

    private static final long EXPIRATION_TIME = 86400000; // 24 hours

    public static String generateToken(String email, String role) {
        return Jwts.builder()
                .setSubject(email)
                .claim("role", role)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .signWith(SignatureAlgorithm.HS256, Base64.getEncoder().encodeToString(SECRET_KEY.getBytes()))
                .compact();
    }

    public static boolean validateToken(String token) {
        try {
            Jwts.parser()
                    .setSigningKey(Base64.getEncoder().encodeToString(SECRET_KEY.getBytes()))
                    .parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            return false; // Invalid token
        }
    }

    public static Optional<Claims> getClaims(String token) {
        try {
            return Optional.of(Jwts.parser()
                    .setSigningKey(Base64.getEncoder().encodeToString(SECRET_KEY.getBytes()))
                    .parseClaimsJws(token)
                    .getBody());
        } catch (Exception e) {
            return Optional.empty();
        }
    }
}
