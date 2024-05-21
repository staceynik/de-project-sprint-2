# Shipping Datamart Project

## Overview

This project implements a data warehouse for a shipping logistics system. It integrates several datasets to create a comprehensive view that facilitates the analysis and management of shipping operations.

## Database Structure

The project constructs several tables and a final view `shipping_datamart` based on these tables:

- `shipping_info`: Contains primary shipping details including vendor IDs, payment amounts, and dates.
- `shipping_transfer`: Details the type and model of transfer, with associated rates.
- `shipping_agreement`: Records agreement details including rates and commissions.
- `shipping_country_rates`: Stores base rate information by country for shipping.
- `shipping_status`: Tracks the current status and key timestamps for each shipment, providing a factual timeline for shipping events.

The `shipping_datamart` view joins these tables to provide a holistic view of the shipping metrics essential for operational and financial analysis.

## SQL Files

The SQL scripts are structured as follows:

- **Table Creation**: Scripts to create tables with necessary constraints and relationships.
- **Data Insertion**: Scripts to populate tables with data. Includes error handling to avoid conflicts.
- **View Creation**: A script to create the `shipping_datamart` view which compiles data from multiple tables into a single analytical framework.
