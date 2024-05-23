-- MySQL to-do list

CREATE DATABASE restaurant_reservations;

USE restaurant_reservations;

-- MySQL Tables and Relationships

CREATE TABLE CUSTOMERS(
  customerId INT NOT NULL UNIQUE AUTO_INCREMENT,
  customerName VARCHAR(45) NOT NULL,
  contactInfo VARCHAR(200),
  PRIMARY KEY (customerId)
);

CREATE TABLE RESERVATIONS(
  reservationId INT NOT NULL UNIQUE AUTO_INCREMENT,
  customerId INT NOT NULL,
  reservationTime DATETIME NOT NULL,
  numberOfGuests INT NOT NULL,
  specialRequests VARCHAR(200),
  PRIMARY KEY (reservationId),
  CONSTRAINT FK_RESERVATIONS_CUSTOMERS FOREIGN KEY (customerId) REFERENCES CUSTOMERS(customerId)
);

CREATE TABLE DININGPREFERENCES(
  preferenceId INT NOT NULL UNIQUE AUTO_INCREMENT,
  customerId INT NOT NULL,
  favoriteTable VARCHAR(45),
  dietaryRestrictions VARCHAR(200),
  PRIMARY KEY (preferenceId),
  CONSTRAINT FK_DININGPREFERENCES_CUSTOMERS FOREIGN KEY (customerId) REFERENCES CUSTOMERS(customerId)
);


-- MySQL Procedures and Modifications

DELIMITER //
CREATE PROCEDURE findReservations(IN customerId INT)
BEGIN
    select * 
    from RESERVATIONS 
    where customerId = customerId;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE addSpecialRequest(IN reservationId INT, IN requests VARCHAR(200))
BEGIN
    UPDATE RESERVATIONS 
    SET specialRequests = requests
    where reservationId = reservationId;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE addReservation(IN customer_id INT, IN reservation_time DATETIME, IN number_of_guests INT, IN special_requests VARCHAR(200))
BEGIN
    DECLARE CustId INTEGER;
    SELECT COUNT(*) INTO CustId 
    From CUSTOMERS 
    WHERE customerId = customer_id;

    IF(CustId > 0) THEN
	    INSERT INTO RESERVATIONS(customerId, reservationTime, numberOfGuests, specialRequests)
	    VALUES (customer_id,reservation_time,number_of_guests,special_requests);
    END IF;
END //
DELIMITER ;


-- Populate the tables with at least three tuples per table.

INSERT INTO CUSTOMERS VALUES(1, 'Robena Krolle', '792-79-7480');
INSERT INTO CUSTOMERS VALUES(2, 'Mikael Orman', '792-79-7483');
INSERT INTO CUSTOMERS VALUES(3, 'Griffith Elsmor', '792-79-7484');

INSERT INTO RESERVATIONS VALUES(1, 1, '2024-01-01 09:00:00', 5, 'Allergic to dust');
INSERT INTO RESERVATIONS VALUES(2, 2, '2024-01-02 12:00:00', 2, 'Laundry services required');
INSERT INTO RESERVATIONS VALUES(3, 3, '2024-01-03 19:00:00', 3, 'Vehicle required');

INSERT INTO DININGPREFERENCES VALUES(1,1,'Window A1','Strictly Veg meals');
INSERT INTO DININGPREFERENCES VALUES(2,2,'Long sofa table','No milk product');
INSERT INTO DININGPREFERENCES VALUES(3,3,'Poolside table','No beef');

