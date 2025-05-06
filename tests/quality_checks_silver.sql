/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs quality checks for data consistency, accuracy,
    and standardization across the 'silver' schema. It includes checks for:
    - Null or duplicate primary keys
    - Unwanted spaces in string fields
    - Data standardization and consistency
    - Invalid date ranges and orders
    - Data consistenct between related fields

Usage Nores:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- missing crm table checks

-- =====================================================================
-- Checking 'silver.erp_cust_az12'
-- =====================================================================
-- Identify Out-of-Range Dates
-- Expectation: Birthdates not between 1924-01-01 and Today
SELECT DISTINCT
    bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01'
    OR bdate > GETDATE();

-- =====================================================================
-- Checking "silver.erp_loc_a101"
-- =====================================================================
-- Data Standardization & Consistency
SELECT DISTINCT
    cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

-- =====================================================================
-- Checking "silver.erp_px_cat_g1v2"
-- =====================================================================
-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT
    *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat)
    OR subcat != TRIM(subcat)
    OR maintenance != TRIM(maintenance);

-- Data Standardization & Consistency
SELECT DISTINCT
    maintenance
FROM silver.erp_px_cat_g1v2;
