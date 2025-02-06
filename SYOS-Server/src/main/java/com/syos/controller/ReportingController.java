package com.syos.controller;

import com.syos.service.ReportingManager;
import com.syos.service.ReportingManagerImpl;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.time.LocalDate;

@Path("/reports")
public class ReportingController {

    private final ReportingManager reportingManager;

    public ReportingController() {
        this.reportingManager = new ReportingManagerImpl();
    }

    @GET
    @Path("/sales")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getTotalSalesReport(@QueryParam("date") String date) {
        try {
            LocalDate reportDate = (date != null) ? LocalDate.parse(date) : LocalDate.now();
            reportingManager.generateTotalSalesReport(reportDate);
            return Response.ok("{\"message\": \"Total Sales Report generated successfully.\"}").build();
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"error\": \"Failed to generate Total Sales Report: " + e.getMessage() + "\"}")
                    .build();
        }
    }

    @GET
    @Path("/reshelving")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getReshelvingReport(@QueryParam("date") String date) {
        try {
            LocalDate reportDate = (date != null) ? LocalDate.parse(date) : LocalDate.now();
            reportingManager.generateReshelvingReport(reportDate);
            return Response.ok("{\"message\": \"Reshelving Report generated successfully.\"}").build();
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"error\": \"Failed to generate Reshelving Report: " + e.getMessage() + "\"}")
                    .build();
        }
    }

    @GET
    @Path("/reorder-level")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getReorderLevelReport(@QueryParam("date") String date) {
        try {
            LocalDate reportDate = (date != null) ? LocalDate.parse(date) : LocalDate.now();
            reportingManager.generateReorderLevelReport(reportDate);
            return Response.ok("{\"message\": \"Reorder Level Report generated successfully.\"}").build();
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"error\": \"Failed to generate Reorder Level Report: " + e.getMessage() + "\"}")
                    .build();
        }
    }

    @GET
    @Path("/stock")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getStockReport(@QueryParam("date") String date) {
        try {
            LocalDate reportDate = (date != null) ? LocalDate.parse(date) : LocalDate.now();
            reportingManager.generateStockReport(reportDate);
            return Response.ok("{\"message\": \"Stock Report generated successfully.\"}").build();
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"error\": \"Failed to generate Stock Report: " + e.getMessage() + "\"}")
                    .build();
        }
    }

    @GET
    @Path("/bill")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getBillReport(@QueryParam("date") String date) {
        try {
            LocalDate reportDate = (date != null) ? LocalDate.parse(date) : LocalDate.now();
            reportingManager.generateBillReport(reportDate);
            return Response.ok("{\"message\": \"Bill Report generated successfully.\"}").build();
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"error\": \"Failed to generate Bill Report: " + e.getMessage() + "\"}")
                    .build();
        }
    }
}
