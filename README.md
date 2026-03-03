# International-visitors-warehouse-dbt-snowflake
## Overview:
End-to-end data engineering project that transforms International Visitor Survey data into a dimensional data warehouse using Snowflake and dbt.  It showcases best practices in data warehousing, data transformation, and analytics. 

The pipeline transforms raw IVS data into analytics-ready data marts to support reporting and business intelligence use cases. It implements the medallion architecture, incremental models, and production-style OBT, fact and dimension design.

## Architecture:
```text
Source Data (CSV) 
        │
        ▼
Snowflake Raw Schema  (Landing / Raw Layer)
        │
        ▼
Staging Layer         (Pre-Processing / Bronze Layer)
        │
        ▼
Intermediate Layer    ( Transformation / Silver Layer)
        │
        ▼
Mart Layer            (Analytics / Gold Layer)
        │
        ▼
Output for Reporting / BI / Analytics
```

## Data Models(Medallion Architecture):
### Staging Layer  
Raw data ingested from raw layer :  
•	```EXPENDITURE_BY_INDUSTRY```-   Contains the percentage breakdown of expenditure.<br>
•	```ITINERARY```- Details of where the respondent stayed on the trip and the number of nights spent.<br>
•	```SURVEY_MAIN_HEADER```- Contains main survey details and all single-response question answers.<br>
•	```TRANSPORT_METHOD```- Provides details of the different transportation methods used by the respondent.<br>
•	```VISITORS_SATISFACTION```- Provides details of the respondent’s rating of their trip to New Zealand.<br>

### Intermediate Layer (Cleaned Data)<br>
Cleaned and standardized data:<br>
•	```INT_EXPENDITURE_BY_INDUSTRY``` - Rounded and structured financial fields for reporting use.<br>
•	```INT_ITINERARY``` – Casted and converted the values.<br>
•	```INT_SURVEY_MAIN_HEADER``` - Standardized data types and handled NA values for downstream models.<br>
•	```INT_TRANSPORT_METHOD```- Passed standardized data forward for mart-level modeling.<br>
•	```INT_VISITORS_SATISFACTION```- Converted and rounded fields.<br>

### Mart Layer (Analytics-Ready)<br>
Business-ready datasets optimized for analytics:<br>
•	```obt``` (One Big Table) – Consolidated analytical table combining Itinerary, Transport Method, and Visitor Satisfaction data into a single reporting-ready dataset.<br>
•	```fact``` - Central fact table containing measurable trip metrics and numeric values for dimensional analysis.<br>
•	```dim_traveller_profile```- Dimension table storing standardized traveller attributes and profile details.<br>
•	```dim_trip_details```- Dimension table capturing structured trip information and descriptive trip attributes.<br>

### Snapshots (SCD Type 2)
Slowly Changing Dimensions to track historical changes:
•	```survey_main_header_snapshot``` – Track respondent’s changes 

## Dataset Information:
Data Source: https://www.mbie.govt.nz/immigration-and-tourism/tourism-research-and-data/tourism-data-releases/international-visitor-survey-ivs/international-visitor-survey-data-download?utm_source=chatgpt.com

This project utilizes five selected CSV files from the original dataset.  
These files were ingested and stored in the raw data layer as part of the data pipeline process.
All selected datasets are available within the project repository under the `data/` folder.

## Project Structure :
```text
international-visitors-warehouse-dbt-snowflake/
  README.md                                # Project overview and instructions
  main.py                                  # Main Python script 
  pyproject.toml                           # Project configuration file for dependencies and packaging
  data/                                     # Raw CSV data files
      ├── expenditure_by_industry.csv
      ├── itiernary.csv
      ├── survey_main_header.csv
      ├── transport_method.csv
      └── visitors_satisfaction.csv
  logs/                                     # Log files generated during project runs
      └── dbt.log
  snowflake_dbt_project/                    # DBT project for Snowflake
      ├── dbt_project.yml                   # DBT project configuration
      ├── profiles_example.yml               # Example DBT profile for connection setup
      │
      ├── analyses/                         # SQL analyses or ad-hoc queries
      │   └── demo.sql
      │
      ├── macros/                           # Custom DBT macros
      │   └── generate_shema_name.sql
      │
      ├── models/                           # DBT models organized by layer
      │   ├── staging/                      # Staging models (raw data transformations)
      │   │   ├── stg_expenditure_by_industry.sql
      │   │   ├── stg_itinerary.sql
      │   │   ├── stg_survey_main_header.sql
      │   │   ├── stg_transport_method.sql
      │   │   └── stg_visitors_satisfaction.sql
      │   │
      │   ├── intermediate/                 # Intermediate transformations combining staging models
      │   │   ├── int_expenditure_by_industry.sql
      │   │   ├── int_itinerary.sql
      │   │   ├── int_survey_main_header.sql
      │   │   ├── int_transport_method.sql
      │   │   ├── int_visitors_satisfaction.sql
      │   │   └── schema.yml                 # Schema tests and model descriptions
      │   │
      │   ├── mart/                         # Final data mart models
      │   │   ├── dim_traveller_profile.sql
      │   │   ├── dim_trip_details.sql
      │   │   ├── fact.sql
      │   │   └── obt.sql
      │   │
      │   └── sources/                      # Source definitions for raw tables
      │       └── sources.yml
      │
      ├── seeds/                            
      ├── snapshots/                        # DBT snapshots for slowly changing tables
      │   └── survey_main_header_snapshot.yml
      └── tests/                            # Custom DBT tests
          └── accom_amount_test.sql
```

## Setup & Installation:
### 1. Clone the repository:  
   ```text
   git clone <repository url>
   ```
### 2. Install Python dependencies:
   ```text
   pip install -r requirements.txt
   or use pyproject.toml
  ```
### 3. Configure DBT profiles (snowflake_dbt_project/profiles_example.yml).
   ```text
   snowflake_dbt_project:
    outputs:
    dev:
      account: <your-account-identifier>
      database: IVS_ANALYTICS_DWH
      password: <your-password>
      role: ACCOUNTADMIN
      schema: raw
      threads: 1
      type: snowflake
      user: <your-username>
      warehouse: COMPUTE_WH
    target: dev
```
### 4.Set Up Snowflake Database and schema
Create database in snowflake catalog and load the source data.<br>
Load CSV files from data/ to Snowflake raw schema:<br>

 1. expenditure_by_industry.csv ->``` IVS_ANALYTICS_DWH.RAW.EXPENDITURE_BY_INDUSTRY```<br>
 2. itiernary.csv -> ```IVS_ANALYTICS_DWH.RAW.ITINERARY```<br>
 3. survey_main_header.csv -> ```IVS_ANALYTICS_DWH.RAW.SURVEY_MAIN_HEADER```<br>
 4. transport_method.csv -> ```IVS_ANALYTICS_DWH.RAW.TRANSFORM_METHOD```<br>
 5. visitors_satisfaction.csv -> ```IVS_ANALYTICS_DWH.RAW.VISITORS_SATISFACTION```<br>

## Usage:
### Run dbt Commands
1. Test Connection
```text
  cd snowflake_dbt_project
  dbt debug
  ```
2. Run  Models
```text
  dbt run
  ```
3.	Run Tests
```text
  dbt test
```
4. Run Snapshots
```text
   dbt snapshot
```
5. Generate Documentation
```text
  dbt docs generate
  dbt docs serve
```
6. Build Everything
```text
   dbt build  # Runs models, tests, and snapshots
```

## Key Features<br>
•	Staging, intermediate, and mart DBT models<br>
•	Incremental data load<br>
•	Snapshots for slowly changing data<br>
•	Custom DBT tests to validate data quality<br>

## Data Quality Checks<br>
•	Ensure data is accurate, complete, and consistent.<br>
•	Check for duplicate records and missing values.<br>
•	Apply custom business rules for correctness.<br>

## Data Lineage<br>
•	Track data from raw input to final output.<br>
•	See dependencies between tables and models.<br>
•	Visualize the full flow from source to consumption.<br>

## Contributing<br>
•	Fork the repository<br>
•	Create a feature branch <br>
•	Commit and push the changes<br>
•	Submit a pull request<br>

## License<br>
This project is for portfolio and learning purposes only.<br>

## Author<br>
Vishakha Desai<br>
Email: vj.vishakhadesai@gmail.com <br>
LinkedIn:  https://www.linkedin.com/in/vishakha-desai<br>
GitHub: https://github.com/vj-vishakhadesai<br>



