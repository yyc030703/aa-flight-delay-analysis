USE airline_dw;

CREATE TABLE dim_state (
    state_id     INT PRIMARY KEY,
    state_abbr   CHAR(2) NOT NULL UNIQUE
);

CREATE TABLE dim_date (
    date_id   INT PRIMARY KEY,
    year      INT NOT NULL,
    month     INT NOT NULL,
    UNIQUE (year, month)
);

CREATE TABLE dim_event_type (
    event_type_id     INT PRIMARY KEY,
    event_type_clean  VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE dim_airport_state (
    airport      CHAR(3) PRIMARY KEY,
    state_abbr   CHAR(2) NOT NULL,
    FOREIGN KEY (state_abbr) REFERENCES dim_state(state_abbr)
);

CREATE TABLE fact_delay_monthly (
    date_id               INT NOT NULL,
    carrier               VARCHAR(10) NOT NULL,
    airport               CHAR(3) NOT NULL,
    year                  INT NOT NULL,
    month                 INT NOT NULL,

    arr_flights           INT DEFAULT 0,
    arr_del15             INT DEFAULT 0,
    carrier_ct            INT DEFAULT 0,
    weather_ct            INT DEFAULT 0,
    nas_ct                INT DEFAULT 0,
    security_ct           INT DEFAULT 0,
    late_aircraft_ct      INT DEFAULT 0,

    arr_cancelled         INT DEFAULT 0,
    arr_diverted          INT DEFAULT 0,

    arr_delay             DOUBLE DEFAULT 0,
    carrier_delay         DOUBLE DEFAULT 0,
    weather_delay         DOUBLE DEFAULT 0,
    nas_delay             DOUBLE DEFAULT 0,
    security_delay        DOUBLE DEFAULT 0,
    late_aircraft_delay   DOUBLE DEFAULT 0,

    PRIMARY KEY (date_id, carrier, airport),

    FOREIGN KEY (date_id)  REFERENCES dim_date(date_id),
    FOREIGN KEY (airport)  REFERENCES dim_airport_state(airport)
);

CREATE TABLE fact_passenger_monthly (
    date_id      INT NOT NULL,
    airport      CHAR(3) NOT NULL,
    year         INT NOT NULL,
    month        INT NOT NULL,

    pax_out      INT DEFAULT 0,
    pax_in       INT DEFAULT 0,
    pax          INT DEFAULT 0,

    PRIMARY KEY (date_id, airport),

    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (airport) REFERENCES dim_airport_state(airport)
);

CREATE TABLE fact_route_monthly (
    date_id       INT NOT NULL,
    origin        CHAR(3) NOT NULL,
    dest          CHAR(3) NOT NULL,
    year          INT NOT NULL,
    month         INT NOT NULL,

    passengers    INT DEFAULT 0,
    seats         INT DEFAULT 0,
    distance      INT,

    PRIMARY KEY (date_id, origin, dest),

    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (origin)  REFERENCES dim_airport_state(airport),
    FOREIGN KEY (dest)    REFERENCES dim_airport_state(airport)
);

CREATE TABLE fact_weather_state_monthly (
    date_id        INT NOT NULL,
    state_abbr     CHAR(2) NOT NULL,

    events         INT DEFAULT 0,
    severe_events  INT DEFAULT 0,
    total_damage   DECIMAL(15,2) DEFAULT 0,
    wx_index       DOUBLE DEFAULT 0,

    PRIMARY KEY (date_id, state_abbr),

    FOREIGN KEY (date_id)    REFERENCES dim_date(date_id),
    FOREIGN KEY (state_abbr) REFERENCES dim_state(state_abbr)
);

CREATE TABLE fact_weather_state_event_type_monthly (
    date_id        INT NOT NULL,
    state_abbr     CHAR(2) NOT NULL,
    event_type_id  INT NOT NULL,
    event_count    INT DEFAULT 0,

    PRIMARY KEY (date_id, state_abbr, event_type_id),

    FOREIGN KEY (date_id)        REFERENCES dim_date(date_id),
    FOREIGN KEY (state_abbr)     REFERENCES dim_state(state_abbr),
    FOREIGN KEY (event_type_id)  REFERENCES dim_event_type(event_type_id)
);

CREATE TABLE fact_fuel_price_monthly (
    date_id   INT NOT NULL,
    price     DOUBLE NOT NULL,

    PRIMARY KEY (date_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);