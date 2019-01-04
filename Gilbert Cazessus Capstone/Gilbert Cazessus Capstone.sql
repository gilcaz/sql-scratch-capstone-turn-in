/* how many distinct campaigns we are investing on */

SELECT COUNT (DISTINCT utm_campaign)
FROM page_visits;


how many distinct sources we are using

SELECT COUNT (DISTINCT utm_source)
FROM page_visits;

relationship of the campaigns and sources

SELECT DISTINCT utm_campaign, utm_source
FROM page_visits;

/* How many first touches is each campaign responsible for */

  WITH first_touch AS (
	SELECT user_id,
  		MIN(timestamp) AS first_touch_at
  	FROM page_visits
  	GROUP BY user_id)
  SELECT ft.user_id,
  	ft.first_touch_at,
    pv.utm_source,
    	pv.utm_campaign
 FROM first_touch ft
 JOIN page_visits pv
 	ON ft.user_id = pv.user_id
  AND ft.first_touch_at = pv.timestamp;

/* How many last touches is each campaign responsible for */

WITH last_touch AS (
	SELECT user_id,
  		MAX(timestamp) AS last_touch_at
  	FROM page_visits
  	GROUP BY user_id)
  SELECT lt.user_id,
  	lt.last_touch_at,
    pv.utm_source,
    	pv.utm_campaign,
      COUNT(utm_campaign)
 FROM last_touch lt
 JOIN page_visits pv
 	ON lt.user_id = pv.user_id
  AND lt.last_touch_at = pv.timestamp
  GROUP BY utm_campaign
  ORDER BY 5 DESC;

/* How many visitors make a purchase */

	SELECT COUNT(DISTINCT user_id)
  	FROM page_visits
    WHERE page_name = '4 - purchase';

/* how many last touches on the purchase page is each campaign responsible for */

WITH last_touch AS (
SELECT user_id,
  MAX(timestamp) AS last_touch_at
  FROM page_visits
  WHERE page_name = '4 - purchase'
  GROUP BY user_id)
  SELECT lt.user_id,
  lt.last_touch_at,
    pv.utm_source,
    pv.utm_campaign,
   COUNT(utm_campaign)
 FROM last_touch lt
 JOIN page_visits pv
 ON lt.user_id = pv.user_id
  AND lt.last_touch_at = pv.timestamp
  GROUP BY utm_campaign
  ORDER BY 5 DESC;




