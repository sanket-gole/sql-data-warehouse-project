-- check for null or duplicates in primary key
-- expectation: No result

SELECT prd_id,
count(*) 
FROM bronze.crm_prd_info
group by prd_id 
having count(*)>1 or prd_id IS NULL


-- check for unwanted space
-- Expectation: No Result
select cst_firstname
from bronze.crm_cust_info
where cst_firstname != TRIM(cst_firstname)

-- checks for null and negative numbers 
-- Expectatitons: No result

select prd_cost
FROM bronze.crm_prd_info
where prd_cost<0 or prd_cost is null

-- Data standerdization and Consistency

SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

-- check for Invalid Date Orders
SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt

--check for in valid dates

SELECT 
NULLIF (sls_order_dt,0) sls_order_dt
FROM bronze.crm_sales_details
where sls_order_dt <=0 
OR LEN(sls_order_dt)!= 8

--- CHECK DATA COnsitency: Between Sales, Quntity, and PRICE
-- >> sales = Quantity* price
-- >> Values must not be null, zero, or negative
SELECT 
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details
where  sls_sales != sls_quantity *sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <=0 OR sls_quantity <=0 OR sls_price <=0


-- Identify outof range date

SELECT DISTINCT
bdate
fROM bronze.erp_cust_az12
WHERE bdate < '1924-01-01' or bdate > GETDATE()
