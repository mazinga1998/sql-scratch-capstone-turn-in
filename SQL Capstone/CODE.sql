SELECT question,
 		COUNT(DISTINCT user_id)
 FROM survey
 GROUP BY 1;
 
 -------------------------------
 
 SELECT DISTINCT q.user_id,
  	h.user_id IS NOT NULL
 	AS 'is_home_try_on',
  	h.number_of_pairs,
  	p.user_id IS NOT NULL
  AS 'is_purchase'
FROM quiz AS 'q'
  LEFT JOIN home_try_on AS 'h'
  	ON q.user_id = h.user_id
  LEFT JOIN purchase AS 'p' 
    ON p.user_id = q.user_id
  LIMIT 10;
  	 
----------------------------------------
WITH funnels AS (
SELECT DISTINCT q.user_id,
  	h.user_id IS NOT NULL
 	AS 'is_home_try_on',
  	h.number_of_pairs,
  	p.user_id IS NOT NULL
  AS 'is_purchase'
FROM quiz AS 'q'
  LEFT JOIN home_try_on AS 'h'
  	ON q.user_id = h.user_id
  LEFT JOIN purchase AS 'p' 
    ON p.user_id = q.user_id)
    
SELECT COUNT(*) AS 'number_quizzed',
 		SUM(is_home_try_on) AS 'number_try',
    SUM(is_purchase) AS 'purchased',
    1.0 * SUM(is_purchase) / SUM(is_home_try_on)
    	AS 'percent_of_purchase'
FROM funnels;

----------------------------------------

WITH funnels AS (  
SELECT DISTINCT q.user_id,
  	h.user_id IS NOT NULL
 	AS 'is_home_try_on',
  	h.number_of_pairs
  AS 'number_of_pairs',
  	p.user_id IS NOT NULL
  AS 'is_purchase'
FROM quiz AS 'q'
  LEFT JOIN home_try_on AS 'h'
  	ON q.user_id = h.user_id
  LEFT JOIN purchase AS 'p' 
    ON p.user_id = q.user_id)              /*    Where number_of_pairs = '3 pairs')   */
SELECT COUNT(*) AS 'number_quizzed',
		SUM(is_home_try_on) AS 'number_try',
    SUM(is_purchase) AS 'purchased',
    1.0 * SUM(is_home_try_on) / COUNT(*) 
    	AS 'percent_try',
    1.0 * SUM(is_purchase) / 
          SUM(is_home_try_on)
    	AS 'percent_of_purchase'
FROM funnels;



-------------------------------------
WITH funnelz AS (
SELECT DISTINCT q.user_id, q.style AS
    'style',
  	h.user_id IS NOT NULL
 	AS 'is_home_try_on',
  	h.number_of_pairs
  AS 'number_of_pairs',
  	p.user_id IS NOT NULL
  AS 'is_purchase'
FROM quiz AS 'q'
  LEFT JOIN home_try_on AS 'h'
  	ON q.user_id = h.user_id
  LEFT JOIN purchase AS 'p' 
    ON p.user_id = q.user_id)
SELECT count (*), style
FROM funnelz
where is_purchase = 1
	and number_of_pairs = '5 pairs'
group by style;





WITH funnels AS (  
SELECT DISTINCT q.user_id, 
		q.style 
  AS 'style',
  	h.user_id IS NOT NULL
 	AS 'is_home_try_on',
  	h.number_of_pairs
  AS 'number_of_pairs',
  	p.user_id IS NOT NULL
  AS 'is_purchase',
    p.product_id IS NOT NULL
  AS 'product',
    p.model_name IS NOT NULL
  AS 'model',
  	p.color IS NOT NULL
  AS 'color',
    p.price
  AS 'price'
FROM quiz AS 'q'
  LEFT JOIN home_try_on AS 'h'
  	ON q.user_id = h.user_id
  LEFT JOIN purchase AS 'p' 
    ON p.user_id = q.user_id)
Select count (*), price
from funnels
where style like 'Women%'
group by 2
order by 1;
