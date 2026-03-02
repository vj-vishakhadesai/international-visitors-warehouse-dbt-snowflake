# international-visitors-warehouse-dbt-snowflake
End-to-end data engineering project that transforms International Visitor Survey data into a dimensional data warehouse using Snowflake and dbt. Implements medallion architecture, incremental models, and production-style OBT, fact and dimension design.

Project Struture :
```text
international-visitors-warehouse-dbt-snowflake/
  README.md                                # Project overview and instructions
  main.py                                  # Main Python script 
  pyproject.toml                           # Project configuration file for dependencies and packaging
  data/                                     # Raw CSV data files
      ├── expenditure_by_industry.csv
      ├── itiernary.csv
      ├── survey_main_method.csv
      ├── transport_method.csv
      └── visitors_satisfaction.csv
  logs/                                     # Log files generated during project runs
      └── dbt.log
  snowflake_dbt_project/                    # DBT project for Snowflake
      ├── dbt_project.yml                   # DBT project configuration
      ├── ExampleProfiles.yml               # Example DBT profile for connection setup
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
