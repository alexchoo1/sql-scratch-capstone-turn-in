--Getting to know Warby Parker

 select *
 from home_try_on
 limit 5;

 select *
 from purchase
 limit 5;

 select *
 from survey
 limit 5;

 select *
 from quiz
 limit 5;
 
--Quiz funnel

select question, count(distinct user_id) as  user_complete
from survey
group by question;

--Home try-on funnel creating a new table

select DISTINCT q.user_id, h.user_id IS NOT NULL AS 'is_home_try_on', h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase'
from quiz as q
left join home_try_on as h on q.user_id = h.user_id
left join purchase as p on q.user_id = p.user_id
limit 10;

--Home try-on funnel overall conversion rate

WITH funnels AS (select DISTINCT q.user_id, h.user_id IS NOT NULL AS 'is_home_try_on', h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase'
from quiz as q
left join home_try_on as h on q.user_id = h.user_id
left join purchase as p on q.user_id = p.user_id)
select count(*) as 'num_quiz', sum(is_home_try_on) as 'sum_home_try_on', sum(is_purchase) as 'sum_is_purchase', 1.0 * SUM(is_home_try_on) / COUNT(user_id) as 'quiz_home_conversion', 1.0 * SUM(is_purchase) / SUM(is_home_try_on) as 'home_purchase_conversion'
from funnels ;

--Home try-on funnel A/B Test Number Of Pairs

WITH funnels AS (select DISTINCT q.user_id, h.user_id IS NOT NULL AS 'is_home_try_on', h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase'
from quiz as q
left join home_try_on as h on q.user_id = h.user_id
left join purchase as p on q.user_id = p.user_id)
select number_of_pairs, count(*) as 'num_quiz', sum(is_home_try_on) as 'sum_home_try_on', sum(is_purchase) as 'sum_is_purchase', 1.0 * SUM(is_home_try_on) / COUNT(user_id) as 'quiz_home_conversion', 1.0 * SUM(is_purchase) / SUM(is_home_try_on) as 'home_purchase_conversion'
from funnels 
group by number_of_pairs;

--Most common style quiz response

select style, count(distinct user_id) as  user_response
from quiz 
group by style
order by user_response desc;

--Most common shape quiz response

select shape, count(distinct user_id) as  user_response
from quiz 
group by shape
order by user_response desc;

--Most common model name purchased

select model_name, count(distinct user_id) as  purchases
from purchase
group by model_name
order by purchases desc;

--Price associated with model name

select model_name, price, count(distinct user_id) as  purchases
from purchase
group by model_name
order by purchases desc;




