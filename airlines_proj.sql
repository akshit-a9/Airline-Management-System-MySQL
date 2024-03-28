CREATE DATABASE Airlines;

USE Airlines;

CREATE TABLE AirCrafts(
	AcID INT PRIMARY KEY.
	AcNumber Varchar(32) NOT NULL,
	Capacity INT NOT NULL,
	MfdBy Varchar(128) NOT NULL,
	MfdOn Datetime NOT NULL
);

INSERT INTO AirCrafts
(AcID, AcNumber, Capacity, MfdBy, MfdOn)
VALUES
(1, "ATR 72-500:, 75, "Alenia Aeronotica", "23 April 1998");


CREATE TABLE Route(
RtID INT,
Airport Varchar(32) NOT NULL,
Destination Varchar(32) NOT NULL,
RouteCode Varchar(16) NOT NULL UNIQUE, 
PRIMARY KEY (RtID)
);

INSERT INTO Route VALUES (1, "Kathmandu", "Pokhra", "KTM-PKR");

CREATE TABLE AirFare( 
AfID INT,
Route INT,
Fare Currency,
FSC Currency,
PRIMARY KEY (AfID),
CONSTRAINT fk_Route FOREIGN KEY (Route) REFERENCES
Route(RtID)
);

INSERT INTO AirFare VALUES (1, 1, 86, 12);

CREATE TABLE Flight_Schedule(
FIID INT,
FlightDate DATETIME, 
Departure DATETIME, 
Arrival DATETIME, 
Aircraft INT,
NetFare INT,
PRIMARY KEY (FIID),
CONSTRAINT fk_AirCraft FOREIGN KEY (AirCraft) REFERENCES
AirCrafts(AcID),
CONSTRAINT fk_NetFare FOREIGN KEY (NetFare) REFERENCES
AirFare(AfID)
);

INSERT INTO Flight_Schedule VALUES
(1, 'January 23, 2012', '23:20', '1:20', 1, 1);

CREATE TABLE Discounts(
DiID INT PRIMARY KEY, 
Title Varchar(32),
Amount INT,
Description Varchar (255)
);

INSERT INTO Discounts VALUES
(1,'Children', 10, 'Discount is provided to all children under the age of 10.');

CREATE TABLE Charges(
ChID INT PRIMARY KEY, 
Title Varchar(32),
Amount INT,
Description Varchar (255)
);

INSERT INTO Charges VALUES 
(2,'Urgent Cancellation', 33.33, '33.3% will be charged for cancellation for booking within 11 hrs from flight time');


CREATE TABLE Countries (
CtID INT PRIMARY KEY,
CountryName Varchar (32) NOT NULL
);

INSERT INTO Countries
VALUES
(1, 'INDIA');


CREATE TABLE State( 
StID INT,
StateName Varchar (32), 
Country INT,
PRIMARY KEY (StID),
CONSTRAINT fk_Country FOREIGN KEY (Country) REFERENCES
Countries(CtID)
);

INSERT INTO State
VALUES
(1, 'Himachal', 1);


CREATE TABLE Contact Details( 
CnID INT PRIMARY KEY, 
Email Varchar (16) NOT NULL, 
Cell Varchar (16) NOT NULL, 
Tel Varchar (16),
Street Varchar (64),
State Varchar(20) NOT NULL,
CONSTRAINT fk _State FOREIGN KEY (State) REFERENCES State(StID)
);

INSERT INTO Contact Details
VALUES
(1,'211438@juitsolan.in', '7018003823', '12', 'Geeta', 1);

CREATE TABLE Passengers(
PsID INT PRIMARY KEY,
Name Varchar (32) NOT NULL,
Address Varchar (64) NOT NULL, 
Age INT NOT NULL,
Nationality Varchar(16) NOT NULL,
Contacts INT NOT NULL,
CONSTRAINT fk_Contacts FOREIGN KEY (Contacts) REFERENCES
Contact Details(CnID)
);

INSERT INTO Passengers
VALUES
(1,'Akshit Sharma', 'H-10, Shastri Bhavan', 20, 'Indian', 1);

CREATE TABLE Branches(
BrID INT PRIMARY KEY,
Center Varchar(16) NOT NULL, 
Address Varchar(32) NOT NULL, 
State INT,
CONSTRAINT fk_StateOfEmployee FOREIGN KEY (State) REFERENCES
State(StID)
);

INSERT INTO Branches
VALUES
(1, 'Himachal', 'Waknaghat, Himachal', 1);

CREATE TABLE Employee
EmpID INT PRIMARY KEY, 
Name Varchar (32) NOT NULL, 
Address Varchar (32) NOT NULL, 
Branch INT NOT NULL,
Designation Varchar(32) NOT NULL, 
Email Varchar (16) NOT NULL, 
Tel Varchar (16) NOT NULL,
Ext INT,
CONSTRAINT fk_Branch FOREIGN KEY (Branch) REFERENCES
Branches(BrID)
);

INSERT INTO Employee
VALUES
(1, 'Niharika', 'H12 - Geeta Bhavan', 1, 'CEO', '211438@juitsolan.in', '7018003823', 12);


CREATE TABLE Transactions(
TSID INT PRIMARY KEY, 
BookingDate DATETIME, 
Departure Date DATETIME,
Passenger INT, 
Flight INT, 
Type BIT, 
Employee INT, 
Charges INT,
Discount INT,
CONSTRAINT fk_Passenger FOREIGN KEY (Passenger) REFERENCES Passengers (PsID),
CONSTRAINT fk_Flight FOREIGN KEY (Flight) REFERENCES Flight Schedule(FIID),
CONSTRAINT fk_Employee FOREIGN KEY (Employee) REFERENCES Employee(EmpID),
CONSTRAINT fk_Charges FOREIGN KEY (Charges) REFERENCES
Charges(ChID),
CONSTRAINT fk_Discount FOREIGN KEY (Discount) REFERENCES
Discounts(DiID)
);

INSERT INTO Transactions
VALUES
(1,'30 November 2022', '17 December 2022', 1, 1, 0, 1, NULL, NULL);
