-- Step 1: Create the database
CREATE DATABASE IF NOT EXISTS DeliveryServiceDB;
USE DeliveryServiceDB;

-- Step 2: Create the Customers table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15) NOT NULL
);

-- Step 3: Create the Drivers table
CREATE TABLE Drivers (
    DriverID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    VehicleNumber VARCHAR(20) NOT NULL UNIQUE
);

-- Step 4: Create the Locations table
CREATE TABLE Locations (
    LocationID INT AUTO_INCREMENT PRIMARY KEY,
    AddressLine VARCHAR(255) NOT NULL,
    City VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(10) NOT NULL
);

-- Step 5: Create the OrderStatus table
CREATE TABLE OrderStatus (
    StatusID INT AUTO_INCREMENT PRIMARY KEY,
    StatusName VARCHAR(50) NOT NULL UNIQUE
);

-- Step 6: Create the Orders table
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    DriverID INT,
    PickupLocationID INT NOT NULL,
    DropoffLocationID INT NOT NULL,
    StatusID INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID),
    FOREIGN KEY (PickupLocationID) REFERENCES Locations(LocationID),
    FOREIGN KEY (DropoffLocationID) REFERENCES Locations(LocationID),
    FOREIGN KEY (StatusID) REFERENCES OrderStatus(StatusID)
);

-- Step 7: Create the Packages table
CREATE TABLE Packages (
    PackageID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    Description VARCHAR(255) NOT NULL,
    Weight DECIMAL(5,2) NOT NULL, -- in kilograms
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 8: Insert sample data

-- Insert Customers
INSERT INTO Customers (FullName, Email, Phone) VALUES
('Alice Johnson', 'alice@example.com', '555-1234'),
('Bob Smith', 'bob@example.com', '555-5678');

-- Insert Drivers
INSERT INTO Drivers (FullName, Phone, VehicleNumber) VALUES
('Carlos Ruiz', '555-0001', 'XYZ-1234'),
('Dana White', '555-0002', 'ABC-5678');

-- Insert Locations
INSERT INTO Locations (AddressLine, City, PostalCode) VALUES
('123 Main St', 'New York', '10001'),
('456 Market Ave', 'Boston', '02108'),
('789 Elm Rd', 'Chicago', '60601'),
('321 Sunset Blvd', 'Los Angeles', '90001');

-- Insert Order Statuses
INSERT INTO OrderStatus (StatusName) VALUES
('Pending'),
('In Transit'),
('Delivered');

-- Insert Orders
INSERT INTO Orders (CustomerID, DriverID, PickupLocationID, DropoffLocationID, StatusID)
VALUES
(1, 1, 1, 2, 1),
(2, 2, 3, 4, 2);

-- Insert Packages
INSERT INTO Packages (OrderID, Description, Weight) VALUES
(1, 'Laptop Box', 2.5),
(1, 'Charger and Accessories', 1.0),
(2, 'Books Set', 4.2);
