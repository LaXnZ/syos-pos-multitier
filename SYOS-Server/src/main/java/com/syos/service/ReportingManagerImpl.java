package com.syos.service;

import com.syos.config.ConnectionPool;
import com.syos.dao.ReportingDAO;
import com.syos.dao.ReportingDAOImpl;
import com.syos.model.Stock;

import java.math.BigDecimal;
import java.sql.Connection;
import java.time.LocalDate;
import java.util.List;
import java.util.concurrent.locks.ReentrantLock;

public class ReportingManagerImpl implements ReportingManager {

    private final ReportingDAO reportingRepository;
    private final ReentrantLock lock = new ReentrantLock(true);

    public ReportingManagerImpl() {
        this.reportingRepository = new ReportingDAOImpl();
    }

    @Override
    public void generateTotalSalesReport(LocalDate date) {
        lock.lock();
        Connection connection = null;
        try {
            connection = ConnectionPool.getConnection();

            List<Object[]> salesReport = reportingRepository.getTotalSalesReport(date, connection);
            BigDecimal totalSalesToday = salesReport.stream()
                    .map(row -> (BigDecimal) row[2])
                    .reduce(BigDecimal.ZERO, BigDecimal::add);

            LocalDate yesterday = date.minusDays(1);
            List<Object[]> salesReportYesterday = reportingRepository.getTotalSalesReport(yesterday, connection);
            BigDecimal totalSalesYesterday = salesReportYesterday.stream()
                    .map(row -> (BigDecimal) row[2])
                    .reduce(BigDecimal.ZERO, BigDecimal::add);

            System.out.println("\n==== Total Sales Report for " + date + " ====");
            salesReport.forEach(row ->
                    System.out.println("Item Code: " + row[0] + ", Quantity Sold: " + row[1] + ", Total Price: " + row[2])
            );

            System.out.println("\nTotal Sales Today: " + totalSalesToday);
            System.out.println("Total Sales Yesterday: " + totalSalesYesterday);
            System.out.println("Sales Difference: " + totalSalesToday.subtract(totalSalesYesterday));

            List<Object[]> mostSoldCategories = reportingRepository.getMostSoldCategories(date, connection);
            System.out.println("\n==== Most Sold Categories ====");
            mostSoldCategories.forEach(row ->
                    System.out.println("Category: " + row[0] + ", Total Sold: " + row[1])
            );

        } catch (Exception e) {
            System.err.println("❌ Error generating sales report: " + e.getMessage());
        } finally {
            lock.unlock();
            if (connection != null) ConnectionPool.releaseConnection(connection);
        }
    }

    @Override
    public void generateReshelvingReport(LocalDate date) {
        lock.lock();
        Connection connection = null;
        try {
            connection = ConnectionPool.getConnection();
            List<Stock> reshelvingReport = reportingRepository.getReshelvingReport(date, connection);

            System.out.println("\n==== Reshelving Report for " + date + " ====");
            reshelvingReport.forEach(stock ->
                    System.out.println("Item Code: " + stock.getItemCode() +
                            ", Quantity in Stock: " + stock.getQuantityInStock() +
                            ", Reshelf Quantity: " + stock.getReshelfQuantity() +
                            ", Shelf Capacity: " + stock.getShelfCapacity() +
                            ", Batch Code: " + stock.getBatchCode() +
                            ", Expiry Date: " + stock.getExpiryDate())
            );
        } catch (Exception e) {
            System.err.println("❌ Error generating reshelving report: " + e.getMessage());
        } finally {
            lock.unlock();
            if (connection != null) ConnectionPool.releaseConnection(connection);
        }
    }

    @Override
    public void generateReorderLevelReport(LocalDate date) {
        lock.lock();
        Connection connection = null;
        try {
            connection = ConnectionPool.getConnection();
            List<Stock> reorderReport = reportingRepository.getReorderLevelReport(date, connection);

            System.out.println("\n==== Reorder Level Report for " + date + " ====");
            reorderReport.forEach(stock ->
                    System.out.println("Item Code: " + stock.getItemCode() +
                            ", Quantity in Stock: " + stock.getQuantityInStock() +
                            ", Minimum Reorder Level: " + stock.getReorderLevel() +
                            ", Batch Code: " + stock.getBatchCode())
            );
        } catch (Exception e) {
            System.err.println("❌ Error generating reorder level report: " + e.getMessage());
        } finally {
            lock.unlock();
            if (connection != null) ConnectionPool.releaseConnection(connection);
        }
    }

    @Override
    public void generateStockReport(LocalDate date) {
        lock.lock();
        Connection connection = null;
        try {
            connection = ConnectionPool.getConnection();
            List<Stock> stockReport = reportingRepository.getStockReport(date, connection);

            System.out.println("\n==== Stock Report for " + date + " ====");
            stockReport.forEach(stock ->
                    System.out.println("Item Code: " + stock.getItemCode() +
                            ", Quantity in Stock: " + stock.getQuantityInStock() +
                            ", Date of Purchase: " + stock.getDateOfPurchase() +
                            ", Expiry Date: " + stock.getExpiryDate() +
                            ", Batch Code: " + stock.getBatchCode())
            );
        } catch (Exception e) {
            System.err.println("❌ Error generating stock report: " + e.getMessage());
        } finally {
            lock.unlock();
            if (connection != null) ConnectionPool.releaseConnection(connection);
        }
    }

    @Override
    public void generateBillReport(LocalDate date) {
        lock.lock();
        Connection connection = null;
        try {
            connection = ConnectionPool.getConnection();
            List<Object[]> billReport = reportingRepository.getBillReport(date, connection);
            BigDecimal totalRevenue = BigDecimal.ZERO;
            int totalBills = billReport.size();

            System.out.println("\n==== Bill Report for " + date + " ====");
            for (Object[] row : billReport) {
                System.out.println("Bill ID: " + row[0] + ", Customer ID: " + row[1] + ", Total Price: " + row[2]);
                totalRevenue = totalRevenue.add((BigDecimal) row[2]);
            }

            System.out.println("\nTotal Bills: " + totalBills);
            System.out.println("Total Revenue: " + totalRevenue);

            BigDecimal avgTransactionValue = totalRevenue.divide(BigDecimal.valueOf(totalBills), BigDecimal.ROUND_HALF_UP);
            System.out.println("Average Transaction Value: " + avgTransactionValue);
        } catch (Exception e) {
            System.err.println("❌ Error generating bill report: " + e.getMessage());
        } finally {
            lock.unlock();
            if (connection != null) ConnectionPool.releaseConnection(connection);
        }
    }
}
