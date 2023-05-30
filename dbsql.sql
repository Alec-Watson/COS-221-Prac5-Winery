CREATE TABLE COS221_Winery (
  WineryID INT PRIMARY KEY,
  Country VARCHAR(255) NOT NULL,
  Region VARCHAR(255) NOT NULL,
  Name VARCHAR(255) NOT NULL
);

CREATE TABLE COS221_Wines (
  WineID INT PRIMARY KEY,
  Vinification VARCHAR(255) NOT NULL,
  Appellation VARCHAR(255) NOT NULL,
  Vintage INT NOT NULL,
  Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
  WineryID INT,
  FOREIGN KEY (WineryID) REFERENCES COS221_Winery(WineryID)
);

-- Create User table
CREATE TABLE COS221_User (
  UserID INT PRIMARY KEY,
  Password VARCHAR(255) NOT NULL,
  Salt VARCHAR(255) NOT NULL,
  WineryID INT NULL, -- Allow null values for WineryID
  FOREIGN KEY (WineryID) REFERENCES COS221_Winery(WineryID)
);

CREATE TABLE COS221_Reviews (
  ReviewID INT PRIMARY KEY,
  UserID INT,
  WineID INT,
  Points INT NOT NULL CHECK (Points >= 1 AND Points <= 100),
  ReviewText VARCHAR(1000),
  FOREIGN KEY (UserID) REFERENCES COS221_User(UserID),
  FOREIGN KEY (WineID) REFERENCES COS221_Wines(WineID)
);
-- Insert into winery
INSERT INTO COS221_Winery (WineryID, Country, Region, Name)
VALUES (1, 'Spain', 'Catalonia', 'L''Arboc');

INSERT INTO COS221_Winery (WineryID, Country, Region, Name)
VALUES (2, 'Italy', 'Tuscany', 'Guidi 1929');

INSERT INTO COS221_Winery (WineryID, Country, Region, Name)
VALUES (3, 'Portugal', 'Colares', 'Adega Viuva Gomes');

INSERT INTO COS221_Winery (WineryID, Country, Region, Name)
VALUES (4, 'France', 'Languedoc-Roussillon', 'Gérard Bertrand');

INSERT INTO COS221_Winery (WineryID, Country, Region, Name)
VALUES (5, 'Hungary', 'Tokaji', 'Royal Tokaji');

-- Insert data into Wines table
INSERT INTO COS221_Wines (WineID, Vinification, Appellation, Vintage,Price, WineryID)
VALUES (1, 'Sparkling Blend', 'Catalonia', 1919, 13.00, 1);

INSERT INTO COS221_Wines (WineID, Vinification, Appellation, Vintage,Price, WineryID)
VALUES (2, 'Cabernet Sauvignon', 'Catalonia', 1999, 55.00, 1);

INSERT INTO COS221_Wines (WineID, Vinification, Appellation, Vintage,Price, WineryID)
VALUES (3, 'Garnacha', 'Catalonia', 2001, 10.00, 1);

INSERT INTO COS221_Wines (WineID, Vinification, Appellation, Vintage,Price, WineryID)
VALUES (4, 'Vernaccia', 'Tuscany', 1929, 14.00, 2);

INSERT INTO COS221_Wines (WineID, Vinification, Appellation, Vintage,Price, WineryID)
VALUES (5, 'White Blend', 'Tuscany', 1994, 140.00, 2);

INSERT INTO COS221_Wines (WineID, Vinification, Appellation, Vintage,Price, WineryID)
VALUES (6, 'Sangiovese', 'Tuscany', 1995, 56.00, 2);

INSERT INTO COS221_Wines (WineID, Vinification, Appellation, Vintage,Price, WineryID)
VALUES (7, 'Ramisco', 'Colares', 1934, 495.00, 3);

INSERT INTO COS221_Wines (WineID, Vinification, Appellation, Vintage,Price, WineryID)
VALUES (8, 'Moscatel', 'Colares', 1963, 400.00, 3);

INSERT INTO COS221_Wines (WineID, Vinification, Appellation, Vintage,Price, WineryID)
VALUES (9, 'Alvarinho', 'Colares', 2001, 10.00, 3);

INSERT INTO COS221_Wines (WineID, Vinification, Appellation, Vintage,Price, WineryID)
VALUES (10, 'Red Blend', 'Languedoc-Roussillon', 1945, 350.00, 4);

INSERT INTO COS221_Wines (WineID, Vinification, Appellation, Vintage,Price, WineryID)
VALUES (11, 'Grenache', 'Languedoc-Roussillon', 2001, 26.00, 4);

INSERT INTO COS221_Wines (WineID, Vinification, Appellation, Vintage,Price, WineryID)
VALUES (12, 'Syrah', 'Languedoc-Roussillon', 2001, 8.00, 4);

INSERT INTO COS221_Wines (WineID, Vinification, Appellation, Vintage,Price, WineryID)
VALUES (13, 'White Blend', 'Tokaji', 1996, 77.00, 5);

INSERT INTO COS221_Wines (WineID, Vinification, Appellation, Vintage,Price, WineryID)
VALUES (14, 'Muscat', 'Tokaji', 2002, 20.00, 5);

INSERT INTO COS221_Wines (WineID, Vinification, Appellation, Vintage, Price, WineryID)
VALUES (15, 'Furmint', 'Tokaji', 2003, 764.00, 5);

-- Insert into user
INSERT INTO COS221_User (UserID, Password, Salt, WineryID)
VALUES (1, 'password1', 'salt1', (SELECT WineryID FROM COS221_Winery WHERE WineryID = 1));

INSERT INTO COS221_User (UserID, Password, Salt, WineryID)
VALUES (2, 'password2', 'salt2', NULL);

INSERT INTO COS221_User (UserID, Password, Salt, WineryID)
VALUES (3, 'password3', 'salt3', (SELECT WineryID FROM COS221_Winery WHERE WineryID = 3));

INSERT INTO COS221_User (UserID, Password, Salt, WineryID)
VALUES (4, 'password4', 'salt4', (SELECT WineryID FROM COS221_Winery WHERE WineryID = 4));

INSERT INTO COS221_User (UserID, Password, Salt, WineryID)
VALUES (5, 'password5', 'salt5', (SELECT WineryID FROM COS221_Winery WHERE WineryID = 5));

-- update the price of the wine as the average of points in reviews
DELIMITER $$
CREATE TRIGGER update_price_trigger AFTER INSERT ON COS221_Reviews
FOR EACH ROW
BEGIN
  UPDATE COS221_Wines
  SET Price = (
    SELECT AVG(Points)*2 FROM COS221_Reviews WHERE WineID = NEW.WineID
  )
  WHERE WineID = NEW.WineID;
END$$
DELIMITER ;

-- Create a separate trigger for UPDATE operation
DELIMITER $$
CREATE TRIGGER update_price_trigger_update AFTER UPDATE ON COS221_Reviews
FOR EACH ROW
BEGIN
  UPDATE COS221_Wines
  SET Price = (
    SELECT AVG(Points)*2 FROM COS221_Reviews WHERE WineID = NEW.WineID
  )
  WHERE WineID = NEW.WineID;
END$$
DELIMITER ;
