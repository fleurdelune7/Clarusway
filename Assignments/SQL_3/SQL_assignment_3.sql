------1. Conversion Rate
--Below you see a table of the actions of customers visiting the website by clicking on two different types of advertisements given by an E-Commerce company.
--Write a query to return the conversion rate for each Advertisement type.

--a.    Create above table (Actions) and insert values,
CREATE TABLE Actions 
(
    Visitor_ID INT,
    Adv_Type  VARCHAR(20),
    Action VARCHAR(20)
);

INSERT Actions VALUES
(1,'A','Left'),
(2,'A','Order'),
(3,'B','Left'),
(4,'A','Order'),
(5,'A','Review'),
(6,'A','Left'),
(7,'B','Left'),
(8,'B','Order'),
(9,'B','Review'),
(10,'A','Review');

SELECT *
FROM Actions

--b.    Retrieve count of total Actions and Orders for each Advertisement Type
CREATE VIEW act_table as 
SELECT Adv_Type,
			SUM(CASE WHEN [Action] = 'Left' THEN 1 ELSE 0 END) AS Left_act,
			SUM(CASE WHEN [Action] = 'Order' THEN 1 ELSE 0 END) AS Order_act,
			SUM(CASE WHEN [Action] = 'Review' THEN 1 ELSE 0 END) AS Review_act		
FROM Actions
GROUP BY adv_type

--c.    Calculate Orders (Conversion) rates for each Advertisement Type by dividing by total count of actions casting as float by multiplying by 1.0.

SELECT Adv_Type,FORMAT(1.0 * Order_act/(Left_act+Order_act+Review_act),'N2') AS Conversion_Rate
FROM act_table




