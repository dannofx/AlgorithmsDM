/* Chapter 14: Exercises Database */
/* This script was created to be used with DB Browser for SQLITE */

/* Creates Database */

CREATE TABLE Complexes (
    ComplexID int NOT NULL,
    ComplexName varchar(500) NOT NULL,
    PRIMARY KEY(ComplexID)
);

CREATE TABLE Tenants (
    TenantID int NOT NULL,
    TenantName varchar(100) NOT NULL,
    PRIMARY KEY(TenantID)
);


CREATE TABLE Buildings (
    BuildingID int NOT NULL,
    ComplexID int NOT NULL,
    BuildingName varchar(100) NOT NULL,
    Address varchar(200) NOT NULL,
    PRIMARY KEY(BuildingID),
    FOREIGN KEY (ComplexID) REFERENCES Complexes(ComplexID)
);

CREATE TABLE Apartments (
    AptID int NOT NULL,
    UnitNumber varchar(10) NOT NULL,
    BuildingID int NOT NULL,
    PRIMARY KEY(AptID),
    FOREIGN KEY (BuildingID) REFERENCES Buildings(BuildingID)
);

CREATE TABLE Requests (
    RequestID int NOT NULL,
    Status varchar(100) NOT NULL,
    AptID int NOT NULL,
    Description varchar(500) NOT NULL,
    PRIMARY KEY(RequestID),
    FOREIGN KEY (AptID) REFERENCES Apartments(AptID)
);

CREATE TABLE AptTenants (
    TenantID int NOT NULL,
    AptID int NOT NULL,
    PRIMARY KEY(TenantID, AptID),
    FOREIGN KEY (TenantID) REFERENCES Tenants(TenantID),
    FOREIGN KEY (AptID) REFERENCES Apartments(AptID)
);

/* Inserts complexes */
INSERT INTO `Complexes`(`ComplexID`,`ComplexName`) VALUES (1,'South Complex');
INSERT INTO `Complexes`(`ComplexID`,`ComplexName`) VALUES (2,'North Complex');

/* Inserts tenants */
INSERT INTO `Tenants`(`TenantID`,`TenantName`) VALUES (1,'Daniel');
INSERT INTO `Tenants`(`TenantID`,`TenantName`) VALUES (2,'Pamela');
INSERT INTO `Tenants`(`TenantID`,`TenantName`) VALUES (3,'Ricardo');
INSERT INTO `Tenants`(`TenantID`,`TenantName`) VALUES (4,'Luis');
INSERT INTO `Tenants`(`TenantID`,`TenantName`) VALUES (5,'Rocio');
INSERT INTO `Tenants`(`TenantID`,`TenantName`) VALUES (6,'Gloria');

/* Inserts buildings */
INSERT INTO `Buildings`(`BuildingID`,`ComplexID`,`BuildingName`,`Address`) VALUES (1,1,'Building #1','Malcolm St 312');
INSERT INTO `Buildings`(`BuildingID`,`ComplexID`,`BuildingName`,`Address`) VALUES (2,1,'Building #5','Malcolm St 313');
INSERT INTO `Buildings`(`BuildingID`,`ComplexID`,`BuildingName`,`Address`) VALUES (3,2,'Building #11','Washington St 105');

/* Inserts apartments */
INSERT INTO `Apartments`(`AptID`,`UnitNumber`,`BuildingID`) VALUES (1,'100',1);
INSERT INTO `Apartments`(`AptID`,`UnitNumber`,`BuildingID`) VALUES (2,'200',1);
INSERT INTO `Apartments`(`AptID`,`UnitNumber`,`BuildingID`) VALUES (3,'300',1);
INSERT INTO `Apartments`(`AptID`,`UnitNumber`,`BuildingID`) VALUES (4,'400',2);
INSERT INTO `Apartments`(`AptID`,`UnitNumber`,`BuildingID`) VALUES (5,'500',2);
INSERT INTO `Apartments`(`AptID`,`UnitNumber`,`BuildingID`) VALUES (6,'600',2);
INSERT INTO `Apartments`(`AptID`,`UnitNumber`,`BuildingID`) VALUES (7,'700',2);
INSERT INTO `Apartments`(`AptID`,`UnitNumber`,`BuildingID`) VALUES (8,'800',2);
INSERT INTO `Apartments`(`AptID`,`UnitNumber`,`BuildingID`) VALUES (9,'900',2);
INSERT INTO `Apartments`(`AptID`,`UnitNumber`,`BuildingID`) VALUES (10,'1000',3);
INSERT INTO `Apartments`(`AptID`,`UnitNumber`,`BuildingID`) VALUES (11,'1100',3);
INSERT INTO `Apartments`(`AptID`,`UnitNumber`,`BuildingID`) VALUES (12,'1200',3);


/* Inserts requests */
INSERT INTO `Requests`(`RequestID`,`Status`,`AptID`,`Description`) VALUES (1,'Open',9,'Wants a big apartment.');
INSERT INTO `Requests`(`RequestID`,`Status`,`AptID`,`Description`) VALUES (2,'Open',10,'The apartment is not finished.');
INSERT INTO `Requests`(`RequestID`,`Status`,`AptID`,`Description`) VALUES (3,'Rejected',11,'Gave false information.');
INSERT INTO `Requests`(`RequestID`,`Status`,`AptID`,`Description`) VALUES (4,'Closed',12,'The contract was signed.');

/* Inserts apartments for tenants */
INSERT INTO `AptTenants`(`TenantID`,`AptID`) VALUES (1,1);
INSERT INTO `AptTenants`(`TenantID`,`AptID`) VALUES (2,2);
INSERT INTO `AptTenants`(`TenantID`,`AptID`) VALUES (3,3);
INSERT INTO `AptTenants`(`TenantID`,`AptID`) VALUES (4,4);
INSERT INTO `AptTenants`(`TenantID`,`AptID`) VALUES (5,5);
INSERT INTO `AptTenants`(`TenantID`,`AptID`) VALUES (1,6);
INSERT INTO `AptTenants`(`TenantID`,`AptID`) VALUES (1,7);
INSERT INTO `AptTenants`(`TenantID`,`AptID`) VALUES (2,8);

