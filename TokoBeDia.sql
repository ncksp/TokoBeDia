GO
CREATE DATABASE TokoBeDia
GO
USE TokoBedia
GO
CREATE TABLE ProductTypes(
	ProductTypeID int IDENTITY(1,1) PRIMARY KEY,
  	Name VARCHAR(50),
	Description TEXT
)  
CREATE TABLE PaymentTypes(
	ID int IDENTITY(1,1) PRIMARY KEY,
  	Type VARCHAR(100),
)
CREATE TABLE Product(
	ProductID int IDENTITY(1,1) PRIMARY KEY,
  	ProductTypeID INT FOREIGN KEY REFERENCES ProductTypes(ProductTypeID),
  	Name VARCHAR(100),
  	Price INT,
  	Stock INT
)
CREATE TABLE Roles(
	RoleID int IDENTITY(1,1) PRIMARY KEY,
  	Name VARCHAR(50),
)  
CREATE TABLE Users(
	UserID int IDENTITY(1,1) PRIMARY KEY,
  	RoleID int FOREIGN KEY REFERENCES Roles(RoleID),
  	Name VARCHAR(150),
  	Email VARCHAR(100),
  	Password VARCHAR(255),
  	Gender VARCHAR (20),
  	Status VARCHAR (20)
)
CREATE TABLE HeaderTransactions(
	TransactionID int IDENTITY(1,1) PRIMARY KEY,
  	UserID int FOREIGN KEY REFERENCES Users(UserID),
  	PaymentTypesID int FOREIGN KEY REFERENCES PaymentTypes(ID),
  	Date Date
)
CREATE TABLE DetailTransactions(
	ID int IDENTITY(1,1) PRIMARY KEY,
	TransactionID int,
  	ProductID int FOREIGN KEY REFERENCES Product(ProductID),
  	Quantity INT,
	FOREIGN KEY (TransactionID) REFERENCES HeaderTransactions(TransactionID),
)
CREATE TABLE Carts(
	ID int IDENTITY(1,1) PRIMARY KEY,
	UserID INT FOREIGN KEY REFERENCES Users(UserID),
	ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
	Quantity INT
) 