# SYOS-Point-of-Sale (SYOS-POS)

SYOS-POS is a multi-user, multi-tier client-server application designed for handling point-of-sale transactions. The application supports multiple user roles, such as Admin and Customer, and allows for managing products, billing, inventory, and stock. The system is structured using a tiered architecture with clear separation of concerns between the client, server, and database layers.

## Table of Contents
- [Project Overview](#project-overview)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
    - [Pre-requisites](#pre-requisites)
    - [Setup Instructions](#setup-instructions)
- [Running the Application](#running-the-application)
- [Database Setup](#database-setup)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Project Overview

SYOS-POS is built to serve as a full-featured point-of-sale solution with features like product management, user authentication, order processing, stock tracking, and more. The application consists of three main layers:
- **Client Layer**: User interface built with JSP and JavaScript (AJAX).
- **Server Layer**: The backend handling business logic and API endpoints, built using Java (Jersey).
- **Database Layer**: PostgreSQL database to manage data.

The system supports concurrent requests, robust session management, and thread safety to handle high-load scenarios efficiently.

## Tech Stack
- **Frontend**: JSP, JavaScript (AJAX)
- **Backend**: Java (Jersey), Servlets
- **Database**: PostgreSQL
- **Containerization**: Docker
- **Build Tool**: Maven
- **API Testing**: Postman, JMeter

## Getting Started

### Pre-requisites
To get started with the project, ensure the following tools are installed:
- **Docker**: For running the PostgreSQL database in a container.
- **Git**: For cloning the repository.
- **Java**: For running the server-side application.
- **Maven**: For building the project.

### Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/LaXnZ/syos-pos.git
   cd syos-pos
   ```

2. **Install Dependencies**:
   Ensure Docker is installed and running on your machine.

3. **Run Setup Script** (Mac or Windows):
    - On Mac, run `./setup_db_mac.sh` to configure the database.
    - On Windows, run `./setup_db_windows.sh` using Git Bash.

4. **Build the Application**:
   ```bash
   mvn clean package -DskipTests
   ```

5. **Run the Application**:
   Deploy the application on Tomcat using the following commands:
   ```bash
   ./deploy.sh
   ```

## Running the Application

Once the application is built and the database is set up, you can run the application by starting the Tomcat server. The system is accessible on:

- **Client**: `http://localhost:8080/SYOS-Client/`
- **Server**: `http://localhost:8080/SYOS-Server/`

## Database Setup

The following SQL scripts are used to set up and populate the database:

- **[create_all_tables.sql](https://github.com/LaXnZ/syos-pos/blob/dev/src/main/resources/create_all_tables.sql)**: Creates all necessary tables.
- **[categories.sql](https://github.com/LaXnZ/syos-pos/blob/dev/src/main/resources/categories.sql)**: Populates the `categories` table.
- **[items.sql](https://github.com/LaXnZ/syos-pos/blob/dev/src/main/resources/items.sql)**: Populates the `items` table with initial data.
- **[stocks.sql](https://github.com/LaXnZ/syos-pos/blob/dev/src/main/resources/stocks.sql)**: Populates the `stocks` table.
- **[migration.sql](https://github.com/LaXnZ/syos-pos/blob/dev/src/main/resources/migration.sql)**: Contains migration commands for schema updates.
- **[drop_all_tables.sql](https://github.com/LaXnZ/syos-pos/blob/dev/src/main/resources/drop_all_tables.sql)**: Drops all tables in the database.

## Testing

The system has been tested for performance and concurrency using Postman and JMeter. Postman was used for API testing and concurrency testing (simulating multiple users), while JMeter was used for stress testing the system under heavy loads.

### Postman Testing
Automated tests were created in Postman for various endpoints such as user login, registration, billing, and product management. These tests were run with multiple virtual users to simulate real-world usage.

### JMeter Testing
JMeter was used to simulate high user traffic and test the performance of the server and database under stress.

## Contributing

Feel free to fork the repository and submit pull requests with improvements or bug fixes. Please ensure your code follows the existing coding conventions and passes all tests.
