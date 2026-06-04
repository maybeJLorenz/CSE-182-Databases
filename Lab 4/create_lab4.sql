DROP SCHEMA lab4 CASCADE;
CREATE SCHEMA lab4;
SET search_path TO lab4;

CREATE TABLE Client (
    clientID INTEGER,
    clientName VARCHAR(40) NOT NULL,
    email VARCHAR(40),
    accountCreationDate DATE,
    premiumMember CHAR(1),
    PRIMARY KEY (clientID),
    UNIQUE (clientName, email)
);

CREATE TABLE DistributionCenter (
    centerCode CHAR(3),
    city VARCHAR(40) NOT NULL,
    country VARCHAR(40),
    numLoadingDocks INTEGER,
    avgProcessingDelayMins INTEGER,
    PRIMARY KEY (centerCode),
    UNIQUE (city, country)
);

CREATE TABLE FreightRoute (
    routeID INTEGER,
    originCenter CHAR(3),
    destCenter CHAR(3),
    scheduledDeparture TIMESTAMP,
    scheduledArrival TIMESTAMP,
    actualDeparture TIMESTAMP NOT NULL,
    actualArrival TIMESTAMP,
    vehicleType VARCHAR(40),
    PRIMARY KEY (routeID),
    FOREIGN KEY (originCenter) REFERENCES DistributionCenter(centerCode),
    FOREIGN KEY (destCenter) REFERENCES DistributionCenter(centerCode)
);

CREATE TABLE LogisticsStaff (
    staffID INTEGER,
    staffName VARCHAR(40) NOT NULL,
    staffRole VARCHAR(40),
    yearsExperience INTEGER,
    PRIMARY KEY (staffID),
    UNIQUE (staffName)
);

CREATE TABLE ShippingOrder (
    orderID INTEGER,
    clientID INTEGER,
    routeID INTEGER,
    orderDate DATE,
    priorityClass CHAR(1),
    shippingCost NUMERIC(9,2),
    paymentMethod VARCHAR(40),
    PRIMARY KEY (orderID),
    FOREIGN KEY (clientID) REFERENCES Client(clientID),
    FOREIGN KEY (routeID) REFERENCES FreightRoute(routeID),
    UNIQUE (orderDate, paymentMethod, clientID)
);

CREATE TABLE PackageDropoff (
    orderID INTEGER,
    staffID INTEGER,
    dropoffTime TIMESTAMP,
    packageCount INTEGER,
    storageBinNumber VARCHAR(40),
    PRIMARY KEY (orderID, staffID),
    FOREIGN KEY (orderID) REFERENCES ShippingOrder(orderID),
    FOREIGN KEY (staffID) REFERENCES LogisticsStaff(staffID)
);

CREATE TABLE RouteStaffAssignment (
    routeID INTEGER,
    staffID INTEGER,
    compensation NUMERIC(9,2),
    PRIMARY KEY (routeID, staffID),
    FOREIGN KEY (routeID) REFERENCES FreightRoute(routeID),
    FOREIGN KEY (staffID) REFERENCES LogisticsStaff(staffID)
);
