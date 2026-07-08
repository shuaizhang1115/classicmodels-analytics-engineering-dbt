# Interview story

## 30-second version

I built an analytics engineering project using dbt and PostgreSQL. Starting from raw order-management tables, I created a staging layer, then built two marts: a star schema for governed analytics and an OBT for dashboard consumption. I added dbt tests for primary keys, composite uniqueness, relationships, accepted values, and positive measures. The project shows both SQL modeling and production-style data quality thinking.

## STAR-style explanation

**Situation**  
Raw operational order data is not directly suitable for analytics because it is normalized around transactions and spread across customer, employee, office, product, order, and order-detail tables.

**Task**  
The goal was to transform the raw data into reliable analytical datasets that could support revenue, margin, fulfillment, customer, product-line, and sales-rep reporting.

**Action**  
I created dbt staging models to standardize field names and data types. Then I designed a star schema with `fact_orders` and dimension tables, plus a denormalized `orders_obt` for BI users. I used surrogate keys, explicit grain definition, relationship tests, uniqueness tests, and business-rule validations.

**Result**  
The final project provides reusable governed models and a simple dashboard-ready table. It also includes local Docker setup, CI configuration, seed data, dbt documentation support, and business analysis SQL examples.

## Strongest technical talking points

- Difference between fact table, dimension table, and OBT.
- Why order-line grain is the right grain for revenue and margin analysis.
- Why OBT is useful for BI even though star schema is cleaner for governance.
- How dbt tests protect data quality and prevent silent reporting errors.
- How the same pattern could be moved to Snowflake, BigQuery, Redshift, or Databricks.
