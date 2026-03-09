-- ================
-- CLEANING DATA 
-- ================
create table company_sales_data
like sales_data;

insert company_sales_data
select* 

from sales_data;
select* 
from company_sales_data;

-- ==========================================================================================================
-- REMOVING DUPLICATES AND  NULL VALUES (OrderID,OrderDate,ProductName,Category,Quantity,UnitPrice,TotalPrice
-- ==========================================================================================================

WITH duplicate_check as(
select*,
row_number() over(
partition by CustomerID,CustomerName,Email order by CustomerID ) as row_num
from company_sales_data
)

SELECT *
FROM duplicate_check
where row_num>1;


DELETE FROM company_sales_data
WHERE CustomerID IN (
    SELECT CustomerID
    FROM (
        SELECT CustomerID,
        ROW_NUMBER() OVER(
        PARTITION BY CustomerID,CustomerName,Email
        ORDER BY CustomerID) AS rn
        FROM company_sales_data
    ) t
    WHERE rn > 1
);

-- ==========================================================================================================
-- finding and cleaning  missing values
-- ==========================================================================================================


SELECT *
FROM company_sales_data
WHERE customername= '' or customername is NULL
order by customerid;

update company_sales_data
set CustomerName=trim(CustomerName);

SELECT *
FROM company_sales_data;

delete 
from company_sales_data
where customername= '' or customername is NULL;

select distinct Email
from company_sales_data
order by 1;

-- ==========================================================================================================
-- Cleaning inconsistent date formats
-- CLEANING OrderDate 
-- ==========================================================================================================

SELECT OrderDate
FROM company_sales_data;


ALTER TABLE company_sales_data
ADD COLUMN CleanOrderDate DATE;

UPDATE company_sales_data
SET CleanOrderDate =
    CASE
        WHEN OrderDate REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
            THEN STR_TO_DATE(OrderDate, '%d/%m/%Y')

        WHEN OrderDate REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{2}$'
            THEN STR_TO_DATE(OrderDate, '%m-%d-%y')

        WHEN OrderDate REGEXP '^[A-Za-z]+ [0-9]{1,2}, [0-9]{4}$'
            THEN STR_TO_DATE(OrderDate, '%M %d, %Y')

        ELSE NULL
    END;

SELECT *
FROM company_sales_data;

update company_sales_data
set OrderDate= str_to_date(OrderDate,'%m%d%Y');

alter table company_sales_data
modify column OrderDate date;

select* 
from company_sales_data;


update company_sales_data
set OrderDate=CleanOrderDate;

alter table company_sales_data
drop CleanOrderDate;

alter table company_sales_data
modify column OrderDate date;

-- ==========================================================================================================
-- CLEANING productName Column
-- ==========================================================================================================


select distinct productname
from company_sales_data
order by 1;

update company_sales_data
set ProductName=trim(ProductName);

-- CLEANING CATERGORY COLUMN

select distinct Category
from company_sales_data
order by 1;

update company_sales_data
set Category=trim(Category);

update company_sales_data
set Category='Tech' 
where Category='tech';

select* 
from company_sales_data;

update company_sales_data
set OrderID=trim(OrderID);

update company_sales_data
set TotalPrice=round(TotalPrice,1);

select*
from company_sales_data;

-- ==========================================================================================================
--  Creating transaction type column
-- Separate Sales and Returns
-- ==========================================================================================================


alter table company_sales_data
add TransactionType int;

alter table company_sales_data
modify TransactionType varchar(20);


update company_sales_data
set TransactionType= case 
						when Quantity < 0 then "Returns"
						when Quantity = 0 then "No Sales"
                        else "sales"
                     end;
                     
select*
from company_sales_data;

---- ==========================================================================================================
-- Standardizing email domains
-- ==========================================================================================================


select distinct Email
from company_sales_data;

update company_sales_data
set Email= replace(email,"gmail.com.com","gmail.com")
where email like '%@gmail.com.com';

update company_sales_data
set Email=trim(Email);

select* 
from company_sales_data;





