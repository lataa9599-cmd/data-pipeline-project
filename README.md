#Data Pipeline Automation & Business Analysis Project

## Overview
This project automates the complete data processing and analysis workflow using Python, Excel VBA, and SQL. It covers data extraction, cleaning, consolidation, and business analysis in a single integrated solution.

The entire workflow is designed for real-time business use and can be executed through a single VBA trigger, enabling one-click automation of the complete pipeline.

---

## Tools & Technologies
- Python (Pandas for data cleaning & analysis)  
- Excel VBA (Automation & data consolidation)  
- SQL (Data extraction & business analysis)  
- Excel (Reporting and output management)  

---

## Workflow

###  Step 1: Data Extraction & Cleaning (Python)
- Identifies the most recent file from the Downloads folder  
- Moves the file to the Raw_Data folder  
- Cleans and transforms the data using Python (Pandas)  
- Saves the cleaned file into the Processed_Data folder  

---

###  Step 2: Data Consolidation (VBA)
- Reads all cleaned files from the Processed_Data folder  
- Consolidates multiple files into a single dataset  
- Clears existing data before pasting to avoid duplication and errors  
- Automates formula application across all rows  

---

###  Step 3: Data Enhancement (VBA)
- Adds calculated columns:
  - Total_Amount  
  - Discount_Amount  
  - Product_Amount  
- Ensures consistent calculations across the dataset  
- Prepares a structured and final report  

---

### Step 4: Business Analysis (Python)
- Performs data analysis using Pandas  
- Generates key insights and KPI-based outputs  
- Saves analysis results in the same Excel report file  
- Adds each analysis as a new sheet for easy access  

---

### Step 5: SQL Integration (Future Scope)
- SQL is used for structured data querying and analysis  
- Can be integrated with dashboards (Power BI / Excel)  
- Supports scalability for larger datasets and advanced reporting  

---

## Key Features
- Fully automated end-to-end data pipeline  
- Combines Python and VBA in a single workflow  
- Consolidated report with raw data and analysis in one file  
- Dynamic addition of analysis sheets  
- One-click execution using VBA, enabling the entire workflow to run automatically  
- Reduces manual effort and improves data accuracy  
- Scalable for future dashboard integration  

---

## Folder Structure
- Downloads → Source files  
- Raw_Data → Initial input files  
- Processed_Data → Cleaned files  
- Report → Final consolidated report with analysis  

---

## Objective
- Automate repetitive data processing tasks  
- Reduce manual errors and delays  
- Provide quick access to business insights  
- Improve efficiency and decision-making  

---

## Outcome
- Reduced manual effort significantly  
- Improved data accuracy and consistency  
- Faster report generation  
- Centralized data and analysis in a single file  

---

## Use Case
This solution is designed for real-time business use. Stakeholders can access both consolidated data and analytical insights in one Excel file, eliminating the need to manage multiple files and reducing delays in reporting.

---

## Future Enhancements
- Integration with Power BI dashboards  
- Automated scheduling of the pipeline  
- Advanced KPI tracking  
- Cloud-based data storage and processing  
