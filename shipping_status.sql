drop table if exists shipping_status cascade;
CREATE TABLE shipping_status (
    shipping_id BIGINT PRIMARY KEY,
    status VARCHAR,
    state VARCHAR,
    shipping_start_fact_datetime TIMESTAMP WITHOUT TIME ZONE,
    shipping_end_fact_datetime TIMESTAMP WITHOUT TIME ZONE
);


WITH ship_max AS (
    SELECT 
        shipping_id,
        MAX(CASE WHEN state = 'booked' THEN state_datetime ELSE NULL END) AS shipping_start_fact_datetime,
        MAX(CASE WHEN state = 'received' THEN state_datetime ELSE NULL END) AS shipping_end_fact_datetime,
        MAX(state_datetime) AS max_state_datetime
    FROM 
        shipping
    GROUP BY 
        shipping_id
)
INSERT INTO shipping_status (shipping_id, status, state, shipping_start_fact_datetime, shipping_end_fact_datetime)
SELECT 
    s.shipping_id,
    s.status,
    s.state,
    sm.shipping_start_fact_datetime,
    sm.shipping_end_fact_datetime
FROM 
    shipping s
JOIN 
    ship_max sm ON s.shipping_id = sm.shipping_id AND s.state_datetime = sm.max_state_datetime;

-- Checking Table Contents

SELECT COUNT(*) from shipping_status;

54.174

SELECT * FROM shipping_status limit 10;

15987	finished	received	2022-01-17 05:05:27.320	2022-01-18 23:31:03.609
49571	finished	returned	2022-04-07 20:43:46.233	2022-04-20 16:28:46.392
5301	finished	received	2021-09-03 14:04:25.036	2021-09-06 10:12:27.476
24186	finished	received	2021-10-13 10:27:22.557	2021-10-23 15:07:07.493
32373	finished	received	2022-04-14 04:36:17.416	2022-04-22 15:46:32.416
11639	finished	received	2021-10-31 21:37:25.146	2021-11-06 08:16:18.844
31625	finished	received	2022-03-30 18:01:11.293	2022-04-22 23:38:22.769
18960	finished	received	2021-12-27 01:57:09.178	2021-12-30 10:41:36.142
38632	finished	received	2022-01-22 11:01:53.590	2022-02-04 16:28:52.590
19250	finished	received	2021-11-26 18:59:13.929	2021-12-22 03:23:34.611


