CREATE DATABASE flight_db;
USE flight_db;
/*Dropping tables*/


/*CREATE DATABASE flight_db;*/
/*USE flight_db;*/
/*Dropping tables*/
DROP TABLE IF EXISTS contact;
DROP TABLE IF EXISTS ticket;
DROP TABLE IF EXISTS passenger;
DROP TABLE IF EXISTS booking;
DROP TABLE IF EXISTS reservation;
DROP TABLE IF EXISTS flight;
DROP TABLE IF EXISTS weekly_schedule;
DROP TABLE IF EXISTS weekday;
DROP TABLE IF EXISTS credit_card;
DROP TABLE IF EXISTS route;
DROP TABLE IF EXISTS airport;
DROP TABLE IF EXISTS credit_card;
DROP TABLE IF EXISTS year;




DROP PROCEDURE IF EXISTS addYear;
DROP PROCEDURE IF EXISTS addDay;
DROP PROCEDURE IF EXISTS addDestination;
DROP PROCEDURE IF EXISTS addRoute;
DROP PROCEDURE IF EXISTS addFlight;
DROP PROCEDURE IF EXISTS addReservation;
DROP PROCEDURE IF EXISTS addPassenger;
DROP PROCEDURE IF EXISTS addContact;
DROP PROCEDURE IF EXISTS addPayment;



DROP FUNCTION IF EXISTS calculateFreeSeats;
DROP FUNCTION IF EXISTS calculatePrice;



CREATE TABLE year (
year INT NOT NULL,
profit_factor DOUBLE NOT NULL,
PRIMARY KEY (year)
);


CREATE TABLE weekday (
day VARCHAR(10) NOT NULL,
year INT NOT NULL,
weekday_factor DOUBLE,
PRIMARY KEY (day,year),
FOREIGN KEY (year) REFERENCES year(year)
);


CREATE TABLE airport (
airport_code VARCHAR(3) NOT NULL,
airport_name VARCHAR(30),
country VARCHAR(30),
city VARCHAR(30),
PRIMARY KEY (airport_code)
);


CREATE TABLE route (
route_id INT AUTO_INCREMENT,
departure VARCHAR(3),
arrival VARCHAR(3),
route_price DOUBLE,
year INT NOT NULL,
PRIMARY KEY (route_id),
FOREIGN KEY (departure) REFERENCES airport(airport_code),
FOREIGN KEY (arrival) REFERENCES airport(airport_code),
FOREIGN KEY (year) REFERENCES year (year)
);


CREATE TABLE weekly_schedule (
id INT NOT NULL AUTO_INCREMENT,
departure_time TIME,
year INT NOT NULL,
week_day VARCHAR(10) NOT NULL,
route INT,
PRIMARY KEY (id),
FOREIGN KEY (route) REFERENCES route(route_id),
FOREIGN KEY (week_day,year) REFERENCES weekday(day,year)
);


CREATE TABLE flight(
flight_number INT AUTO_INCREMENT,
week_number INT,
route INT,
weekly_schedule INT,
PRIMARY KEY(flight_number),
FOREIGN KEY(route) REFERENCES route(route_id),
FOREIGN KEY(weekly_schedule) REFERENCES weekly_schedule(id)
);



/*Credit card*/
CREATE TABLE credit_card (
card_number BIGINT,
holder_name VARCHAR(30) NOT NULL,
email VARCHAR(30),
PRIMARY KEY(card_number)
);



/*Reservation*/
CREATE TABLE reservation (
reservation_number INT NOT NULL AUTO_INCREMENT,
reservation_seats INT,
flight INT,
PRIMARY KEY(reservation_number),
FOREIGN KEY(flight) REFERENCES flight(flight_number)
);


/*Create Table Passenger*/
CREATE TABLE passenger (
passport_number INT NOT NULL,
name VARCHAR(30),
reservation_number INT,
PRIMARY KEY (passport_number),
FOREIGN KEY(reservation_number) REFERENCES reservation(reservation_number)
);

CREATE TABLE contact (
passport_number INT NOT NULL,
phone_number BIGINT NOT NULL,
email VARCHAR(30),
PRIMARY KEY (passport_number),
FOREIGN KEY (passport_number) REFERENCES passenger(passport_number)
);

/*Booking*/
CREATE TABLE booking (
reservation_number INT NOT NULL,
total_price DOUBLE,
card_number BIGINT default NULL,
flight_number INT,
status boolean default 0,
PRIMARY KEY(reservation_number),
FOREIGN KEY(card_number) REFERENCES credit_card(card_number),
FOREIGN KEY(reservation_number) REFERENCES reservation(reservation_number),
FOREIGN KEY(flight_number) REFERENCES flight(flight_number)
);



Create table ticket(
ticket_number INT NOT NULL,
booking_number INT,
passenger_number INT,
PRIMARY KEY(ticket_number),
FOREIGN KEY(booking_number) REFERENCES booking(reservation_number),
FOREIGN KEY(passenger_number) REFERENCES passenger(passport_number)
);



/*question 3 a) */
/* add year */

Delimiter //
CREATE PROCEDURE addYear(IN in_year INT,IN factor DOUBLE)
	BEGIN 
		if NOT EXISTS (select year from year where year = in_year)
		then 
		insert into year(year,profit_factor) values (in_year,factor);
		end if;
	END;
//
Delimiter ;



/*question 3 b) */

Delimiter //
CREATE PROCEDURE addDay(IN in_year INT,IN in_day varchar(10), IN day_factor DOUBLE)
	BEGIN 
		if NOT EXISTS (select day from weekday where day = in_day)
		then 
		insert into weekday(year,day,weekday_factor) values (in_year,in_day,day_factor);
		end if;
	END;
//
Delimiter ;


/*question 3 c) */


Delimiter //
CREATE PROCEDURE addDestination(IN in_airport_code varchar(3),IN in_name varchar(30),IN in_country varchar(30))
	BEGIN 
		if NOT EXISTS (select airport_code from airport where airport_code = in_airport_code)
		then 
		insert into airport(airport_code,airport_name,country) values (in_airport_code,in_name,in_country);
		end if;
	END;
//
Delimiter ;



/*question 3 d) */

Delimiter //
CREATE PROCEDURE addRoute(IN departure_airport_code varchar(3),IN arrival_airport_code varchar(3),IN in_year INT, IN routeprice DOUBLE)
	BEGIN 
		#if NOT EXISTS (select * from route where year = in_year AND arrival = arrival_airport_code AND departure = departure_airport_code AND departure_airport_code = arrival_airport_code)
		if NOT EXISTS (select * from route where year = in_year AND arrival = arrival_airport_code AND departure = departure_airport_code)
		then 
		insert into route(departure,arrival,year,route_price) values (departure_airport_code,arrival_airport_code,in_year,routeprice);
		end if;
	END;
//
Delimiter ;





/*question 3 e) */




Delimiter //
CREATE PROCEDURE addFlight(IN departure_airport_code varchar(3),IN arrival_airport_code varchar(3),IN in_year INT, IN in_day varchar(10), IN in_departure_time TIME)
	BEGIN 
		/*Initilize Variables*/

		DECLARE i INT DEFAULT 1;
		DECLARE weekly_schedule_id INT;
		DECLARE find_route_id INT;

		if NOT EXISTS (select * from weekly_schedule where departure_time = in_departure_time and year = in_year and week_day = in_day)
		then
			SET find_route_id = (select route_id from route where departure = departure_airport_code and arrival = arrival_airport_code and year = in_year);
			
			insert into weekly_schedule(departure_time,year,week_day,route) values(in_departure_time,in_year,in_day,find_route_id );

			SET weekly_schedule_id = LAST_INSERT_ID();
			WHILE i <= 52 DO
	        	insert into flight (week_number,route, weekly_schedule) VALUES(i,find_route_id, weekly_schedule_id);
	        	SET i = i + 1;
	        END WHILE;
	    end if;

	END;
//
Delimiter ;




/*question 4a calculate free seats*/

Delimiter //
CREATE FUNCtiON calculateFreeSeats(flight_number int) 
	RETURNS int
	DETERMINISTIC
	BEGIN 
		DECLARE t_seats INT;
		set t_seats = (select count(t.ticket_number) from booking b inner join ticket t on t.booking_number = b.reservation_number where b.flight_number = flight_number and b.status = 1);
    	#set t_seats = (select r.reservation_seats from booking b inner join ticket t on t.booking_number = b.reservation_number inner join reservation r on r.reservation_number = b.reservation_number  where b.flight_number = flight_number and b.status = 1);
    	RETURN(40 - t_seats);
	END;
//
Delimiter ;




/*qustion 4b calculatePrice */
Delimiter //
CREATE FUNCtiON calculatePrice(flightnumber int) 
	RETURNS int
	DETERMINISTIC
	BEGIN 
		DECLARE booked_seats INT;
		DECLARE route_price DOUBLE;
		DECLARE week_day_factor DOUBLE;
		DECLARE year_profit_factor DOUBLE;
		DECLARE total_price DOUBLE;
	
		set booked_seats = (select count(t.ticket_number) from booking b inner join ticket t on t.booking_number = b.reservation_number where b.flight_number = flightnumber and b.status = 1);
    	
    	set week_day_factor = (select d.weekday_factor from weekly_schedule as wk, flight as f, weekday as d where f.flight_number = flightnumber and f.weekly_schedule = wk.id and d.day = wk.week_day and d.year = wk.year);
    	set year_profit_factor = (select y.profit_factor from weekly_schedule as wk, flight as f, year as y where f.flight_number = flightnumber and f.weekly_schedule = wk.id and wk.year = y.year );
    	set route_price = (select r.route_price from weekly_schedule as wk, flight as f, route as r where f.flight_number = flightnumber and f.weekly_schedule = wk.id and f.route = r.route_id );
    	set total_price = (route_price * week_day_factor * booked_seats +1)/(40 * year_profit_factor);
    	RETURN(total_price);
	END;
//
Delimiter ;


/*question 5 Trigger */

DROP TRIGGER IF EXISTS unique_ticket_no;
delimiter //
CREATE TRIGGER unique_ticket_no BEFORE INSERT ON ticket FOR EACH ROW
	BEGIN
	    SET NEW.ticket_number = CEIL( 12345 + (RAND() * 54321));
	END;
//
Delimiter ;



/* Question 6-a add reservation */
Delimiter //
CREATE PROCEDURE addReservation(IN departure_airport_code varchar(3),IN arrival_airport_code varchar(3),IN in_year INT, IN week INT,IN day varchar(10),IN in_departure_time TIME,IN in_number_of_passengers INT,OUT output_reservation_nr INT)
	BEGIN 
		DECLARE flightnumber INT;

		SET flightnumber = (select f.flight_number from route as r inner join weekly_schedule as wk on r.route_id = wk.route inner join flight as f on f.weekly_schedule = wk.id where r.arrival = arrival_airport_code and r.departure = departure_airport_code and r.year = in_year and wk.departure_time = in_departure_time and wk.week_day = day and wk.year = in_year and f.route = r.route_id and f.week_number = week);

		IF flightnumber is NULL THEN
        	select 'There exist no flight or the given route, date and time.';

       	ELSEIF calculateFreeSeats(flightnumber) < in_number_of_passengers THEN
    		Select 'There are not enough seats available on the chosen flight.';
    	ELSE 
        	
			INSERT INTO reservation(reservation_seats,flight) VALUES (in_number_of_passengers,flightnumber);
			set output_reservation_nr = last_insert_id();
    	END IF;


    	

		
	END;
//
Delimiter ;





/* Question 6-b add passengar */
Delimiter //
CREATE PROCEDURE addPassenger(IN reservation_nr INT, IN passport_number INT, IN in_name VARCHAR(30))
	BEGIN 
		DECLARE passenger_passport INT;

		IF (NOT EXISTS(SELECT reservation_number FROM reservation WHERE reservation_number = reservation_nr)) THEN
        	select 'The given reservation number does not exist.';
    	END IF;


    	IF (EXISTS(SELECT * FROM booking WHERE reservation_number=reservation_nr)) THEN
    		select'The booking has already been payed and no further passengers can be added.';
   		END if;

    	SET passenger_passport =  (SELECT passport_number FROM passenger WHERE passenger.passport_number = passport_number);

    	IF passenger_passport IS NULL THEN
        	insert into passenger (passport_number, name,reservation_number) VALUES (passport_number, in_name,reservation_nr);
        END IF;    	
        	


        	
    	
		
	END;
//
Delimiter ;




/* Question 6-c add contact */

Delimiter //
CREATE PROCEDURE addContact(IN reservation_nr INT,IN in_passport_number INT,IN in_email varchar(30), IN phone BIGINT)
	BEGIN 
		
		IF NOT EXISTS (select reservation_number from reservation where reservation_number = reservation_nr) THEN
			select 'The given reservation does not exist.';
		END IF;


		IF NOT EXISTS(SELECT passport_number FROM passenger WHERE passenger.passport_number = in_passport_number) THEN
        	select 'The person is not a passenger of the reservation.';
        ELSE
        	insert into contact(passport_number,phone_number,email) values (in_passport_number,phone,in_email) ON DUPLICATE KEY UPDATE contact.email=email, contact.phone_number=phone;
    	END IF;

	END;
//
Delimiter ;


 
/*question 6-d addPayment*/
Delimiter //
CREATE PROCEDURE addPayment(IN reservation_nr INT, IN cardholder_name VARCHAR(30), IN credit_card_number BIGINT)
	BEGIN 
		DECLARE flightnumber INT;
		DECLARE r_seats INT;
		DECLARE total_price DOUBLE;
		DECLARE p_number INT;

		
		IF NOT EXISTS (select DISTINCT(reservation_number) from reservation where reservation_number = reservation_nr) THEN
			select 'The given reservation does not exist.';
		ELSE
			SET flightnumber = (SELECT flight FROM reservation WHERE reservation_number=reservation_nr);
			SET r_seats = (SELECT count(*) FROM passenger WHERE reservation_number=reservation_nr);
			

			IF calculateFreeSeats(flightnumber) < r_seats THEN
	        	#DELETE FROM reservation WHERE reservation_number=reservation_nr;
	        	select 'There are not enough seats available on the flight anymore, deleting reservation.';
	    	ELSE

	    		SET p_number = (select c.passport_number from passenger p inner join contact c on p.passport_number = c.passport_number where reservation_number = reservation_nr);
	    		
	    		IF p_number is NULL THEN
					select "The reservation has no contact yet";
				ELSE
					#change here
					#set p_number = (select passport_number from passenger where reservation_number = reservation_nr);
					
			    	INSERT INTO credit_card(card_number,holder_name) VALUES(credit_card_number, cardholder_name)
		        	ON DUPLICATE KEY UPDATE card_number = credit_card_number;
				
					set total_price = calculatePrice(flightnumber);

					INSERT INTO booking (reservation_number,total_price,card_number,flight_number,status) VALUES (reservation_nr, total_price, credit_card_number,flightnumber,TRUE);

					INSERT INTO ticket (booking_number, passenger_number) values(reservation_nr,p_number);
				END IF;
	    	END IF;
		END IF;
		


	END;
//
Delimiter ;


CREATE VIEW allFlights AS select d.airport_name as departure_airport, a.airport_name as destination_airport,w.departure_time,w.week_day as departure_day,f.week_number as departure_week,w.year as departure_year,calculateFreeSeats(f.flight_number) as nr_of_free_seats,calculatePrice(f.flight_number) as current_price_per_seat 
from airport d, airport a,weekly_schedule w, flight f, route r where d.airport_code = r.departure and a.airport_code = r.arrival and w.route = r.route_id and f.weekly_schedule = w.id;



