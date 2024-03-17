CREATE TABLE
  Flight (
    flight_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    flight_number VARCHAR2 (6) NOT NULL,
    base_price NUMBER (10, 2) NOT NULL,
    tax_percent NUMBER (5, 2) NOT NULL,
    surcharge NUMBER (10, 2) NOT NULL
  );

CREATE TABLE
  AirplaneModel (
    airplane_model VARCHAR2 (15) PRIMARY KEY,
    family VARCHAR2 (15) NOT NULL,
    capacity NUMBER (3) NOT NULL,
    cargo_capacity NUMBER (10, 2) NOT NULL,
    volume_capacity NUMBER (10, 2) NOT NULL
  );

CREATE TABLE
  Airport (
    airport_code VARCHAR2 (3) PRIMARY KEY,
    name VARCHAR2 (80) NOT NULL,
    type VARCHAR2 (20) NOT NULL,
    city VARCHAR2 (80) NOT NULL,
    country VARCHAR2 (30) NOT NULL,
    runways NUMBER (2) NOT NULL
  );

CREATE TABLE
  Scale (
    scale_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    flight_id NUMBER REFERENCES Flight (flight_id) ON DELETE CASCADE,
    airplane_model VARCHAR2 (15) REFERENCES AirplaneModel (airplane_model),
    origin_airport VARCHAR2 (3) NOT NULL REFERENCES Airport (airport_code),
    destination_airport VARCHAR2 (3) NOT NULL REFERENCES Airport (airport_code),
    departure_date TIMESTAMP NOT NULL,
    arrival_date TIMESTAMP NOT NULL,
    price NUMBER (10, 2) NOT NULL
  );

CREATE TABLE
  Employee (
    employee_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    name VARCHAR2 (80) NOT NULL,
    job_title VARCHAR2 (30) NOT NULL
  );

CREATE TABLE
  FlightCrew (
    flight_crew_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    flight_id NUMBER REFERENCES Flight (flight_id) ON DELETE CASCADE,
    employee_id NUMBER REFERENCES Employee (employee_id),
    flight_role VARCHAR2 (20) NOT NULL
  );

CREATE TABLE
  Luggage (
    LUGGAGE_ID NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    LUGGAGE_TYPE VARCHAR2 (100) NOT NULL,
    EXTRA_CHARGE FLOAT DEFAULT 0,
    QUANTITY NUMBER (4) NOT NULL,
    DESCRIPTION VARCHAR2 (150),
    WIDTH FLOAT NOT NULL,
    HEIGHT FLOAT NOT NULL,
    WEIGHT FLOAT NOT NULL,
    USER_ID NUMBER NOT NULL,
    FLIGHT_ID NUMBER REFERENCES flight NOT NULL,
    BOOKING_ID NUMBER NOT NULL,
    placement_area_ID REFERENCES PlacementArea NOT NULL
  );

CREATE TABLE
  PlacementArea (
    PLACEMENT_AREA_ID NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    NAME VARCHAR2 (100) NOT NULL
  );

CREATE TABLE
  LostLuggageInfo (
    LostLuggageID NUMBER (10, 0) GENERATED ALWAYS AS IDENTITY INCREMENT BY 1 START
    WITH
      1 PRIMARY KEY,
      Shipping_address VARCHAR2 (150) NOT NULL,
      phone_number VARCHAR2 (150) NOT NULL,
      receiver_name VARCHAR2 (150) NOT NULL
  );

CREATE TABLE
  MedicalInfo (
    Medical_info_ID NUMBER (10, 0) GENERATED ALWAYS AS IDENTITY INCREMENT BY 1 START
    WITH
      1 PRIMARY KEY,
      --fk passenger--
      medical_conditions VARCHAR2 (150),
      allergies VARCHAR2 (150),
      essential_medications VARCHAR2 (150)
  );

Create table
  Boardingpass (
    Boarding_pass_ID NUMBER (10, 0) GENERATED ALWAYS AS IDENTITY INCREMENT BY 1 START
    WITH
      1 PRIMARY KEY,
      --fk passenger to get name, phone, document--
      --fk seat, to get asigned_seat to a passenger or asigned a empy seat--
      --fk reservation to get reservation_status--
      Flight_ID NUMBER (10) REFERENCES Flight NOT NULL, --needed departure_date, origin and destination camps
      medical_info_ID NUMBER (10) REFERENCES Medical_info NOT NULL,
      Lost_Luggage_ID NUMBER (10) REFERENCES Lost_Luggage NOT NULL,
      boarding_time TIMESTAMP NOT NULL
  );