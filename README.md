# AA Flight Delay Cause Analysis (2020–2025)

## Project Highlights
- Built an end-to-end analytics pipeline to analyze American Airlines flight delay drivers from 2020 to 2025 using open-source aviation, weather, and fuel datasets.
- Designed and implemented a star-schema data warehouse in Snowflake with dimension and monthly fact tables to support scalable analytics.
- Developed Python ETL workflows to clean, standardize, and aggregate raw data into analytics-ready tables.
- Delivered interactive Tableau dashboards to examine delay trends, internal operational drivers, and weather-related impacts.
- Integrated external datasets such as NOAA storm events and BTS passenger and route traffic, with jet fuel prices modeled for future exploratory analysis.

---

## Tech Stack
- **Staging Database:** MySQL (Google Cloud SQL)
- **Data Warehouse:** MySQL, Snowflake
- **Data Processing:** Python (pandas)  
- **Data Modeling:** Star schema (fact and dimension tables)  
- **Visualization:** Tableau  

---

## Overview
Flight delays significantly impact airline operations and customer experience. This project analyzes U.S. airline delay patterns with a focus on American Airlines, identifying how operational factors, seasonality, passenger volume, weather events, and fuel prices contribute to delay trends over time.

### Key Questions
- How have flight delays evolved from 2020 to 2025?
- Which internal delay components contribute most to total delay minutes?
- Are there clear seasonal patterns or peak delay months?
- How do external conditions such as weather severity relate to delays?

---

## Data Sources (Open Source)
All raw data used in this project comes from publicly available sources.

- **Bureau of Transportation Statistics (BTS)**  
  Airline On-Time Performance and Delay Causes  
  https://www.transtats.bts.gov/OT_Delay/OT_DelayCause1.asp

- **BTS TranStats T-100 Domestic Segment**  
  Passenger, seat capacity, and route-level statistics  
  https://transtats.bts.gov/DL_SelectFields.aspx?gnoyr_VQ=GEE&QO_fu146_anzr=Nv4+Pn44vr45

- **NOAA Storm Events Database**  
  Severe weather event records by location and date  
  https://www.ncei.noaa.gov/pub/data/swdi/stormevents/csvfiles/

- **U.S. Energy Information Administration (EIA)**  
  U.S. Gulf Coast Kerosene-Type Jet Fuel Spot Prices  
  https://www.eia.gov/petroleum/

> Note: Raw datasets are not included in this repository. This repo focuses on data modeling, ETL logic, and analytics outputs.

---

## Architecture
1. Download raw open-source datasets from BTS, NOAA, and EIA.
2. Load raw data into a relational staging layer in **MySQL (Google Cloud SQL)**.
3. Clean, standardize, and aggregate data using Python ETL workflows.
4. Load curated, analytics-ready tables into **Snowflake** using a star-schema design.
5. Build interactive dashboards and analytics in **Tableau Public**.

This layered architecture separates raw ingestion, transformation, and analytics to improve data quality, reproducibility, and scalability.

---

## Data Model
### Dimensions
- `dim_date`
- `dim_state`
- `dim_event_type`
- `dim_airport_state`

### Fact Tables
- `fact_delay_monthly`
- `fact_passenger_monthly`
- `fact_route_monthly`
- `fact_weather_state_monthly`
- `fact_weather_state_event_type_monthly`
- `fact_fuel_price_monthly`

The analytical warehouse is modeled using a star schema, with monthly fact tables capturing delay, passenger, route, weather, and fuel metrics, and shared dimensions enabling flexible joins across operational and external drivers.
<img width="500" height="400" alt="• fact route moethly y" src="https://github.com/user-attachments/assets/e6d93e19-3d34-4c4b-8fc9-8aaf5697d2a3" />

---

## Tableau Dashboard
The interactive dashboards are published on Tableau Public.

🔗 **Tableau Public Story:**  
https://public.tableau.com/app/profile/yung.chyi.yang/viz/AAFlightDelayAnalysis/Story1

### Dashboard Sections
- **Delay Trends and Operational Drivers**
  - Monthly delay trends from 2020 to 2025
  - Internal delay components such as carrier delay, late aircraft delay, NAS delay, and security delay
  - Identification of peak delay months
  - Relationship between weather events and months
    
- **Weather Impact of Flight Delays**
  - Weather delay rate trends by month
  - Relationship between weather severity index and arrival delays
  - Geographic distribution of severe weather events

Interactive filters allow exploration by year, month, airport, and state.

---

## Repository Structure
- aa-flight-delay-analysis/
- sql/ _# Data warehouse table creation scripts_
- etl/ _# Python notebooks for data cleaning and profiling_
- docs/ _# Documentation and data dictionary_

---

## Key Findings
- Flight delays increased steadily from 2020 to 2025, aligning with post-pandemic recovery and rising passenger volumes.
- Internal operational factors, particularly carrier and late aircraft delays, consistently accounted for the largest share of total delay minutes.
- Clear seasonal patterns were observed, with delay peaks occurring during late spring and summer months.
- Severe weather events contributed to delay spikes, but operational factors remained the dominant and more controllable drivers overall.

These findings highlight the importance of separating operational constraints from external conditions when analyzing airline performance.

---

### Notes
- No raw data are stored in this repository
- This project emphasizes on data modeling, ETL design, and analytical reasoning rather than data collection.
- All data sources are publicly available and cited above.
