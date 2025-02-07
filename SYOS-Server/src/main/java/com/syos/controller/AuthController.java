package com.syos.controller;

import com.syos.model.User;
import com.syos.service.AuthService;

import javax.json.JsonObject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/auth")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class AuthController {
    private final AuthService authService = new AuthService();

    @POST
    @Path("/register")
    public Response registerUser(User user) {
        String result = authService.registerUser(user);
        return result.contains("✅") ? Response.status(Response.Status.CREATED).entity(result).build()
                : Response.status(Response.Status.BAD_REQUEST).entity(result).build();
    }

    @POST
    @Path("/login")
    public Response loginUser(@QueryParam("email") String email, @QueryParam("password") String password) {
        JsonObject response = authService.login(email, password);

        if (response.containsKey("error")) {
            return Response.status(Response.Status.UNAUTHORIZED).entity(response).build();
        }

        return Response.ok(response).build();
    }

    @GET
    @Path("/validate")
    public Response validateToken(@QueryParam("token") String token) {
        boolean isValid = authService.validateToken(token);
        return isValid ? Response.ok("✅ Token is valid").build() : Response.status(Response.Status.UNAUTHORIZED).entity("❌ Invalid Token").build();
    }
}
