CREATE OR REPLACE VIEW shipping_datamart AS
SELECT
    si.shipping_id,
    si.vendor_id,
    st.transfer_type,
    DATE_PART('day', ss.shipping_end_fact_datetime - ss.shipping_start_fact_datetime) AS full_day_at_shipping,
    CASE WHEN ss.shipping_end_fact_datetime > si.shipping_plan_datetime THEN 1 ELSE 0 END AS is_delay,
    CASE WHEN ss.status = 'finished' THEN 1 ELSE 0 END AS is_shipping_finish,
    CASE WHEN ss.shipping_end_fact_datetime > si.shipping_plan_datetime THEN DATE_PART('day', ss.shipping_end_fact_datetime - si.shipping_plan_datetime) ELSE 0 END AS delay_day_at_shipping,
    si.payment_amount,
    si.payment_amount * (scr.shipping_country_base_rate + sa.agreement_rate + st.shipping_transfer_rate) AS vat,
    si.payment_amount * sa.agreement_commission AS profit
FROM
    shipping_info si
INNER JOIN shipping_status ss ON si.shipping_id = ss.shipping_id
INNER JOIN shipping_transfer st ON si.shipping_transfer_id = st.id
INNER JOIN shipping_country_rates scr ON si.shipping_country_rate_id = scr.id
INNER JOIN shipping_agreement sa ON si.shipping_agreement_id = sa.agreement_id;

-- Проверка содержимого таблицы

SELECT * FROM shipping_datamart LIMIT 10;

1	1	1p	10.0	1	1	0.0	6.06	1.181700	0.1212
2	1	1p	5.0	1	1	0.0	21.93	3.837750	0.2193
3	1	1p	1.0	1	1	0.0	3.10	0.279000	0.0310
4	3	1p	6.0	0	1	0.0	8.57	0.728450	0.0857
5	3	1p	12.0	1	1	7.0	1.50	0.172500	0.0150
6	1	1p	1.0	1	1	0.0	3.73	0.708700	0.0746
7	1	3p	1.0	1	1	0.0	5.27	0.395250	0.1581
8	1	1p	2.0	1	1	0.0	4.79	0.311350	0.1437
9	1	1p	2.0	1	1	0.0	5.58	0.362700	0.1674
10	1	1p	10.0	1	1	0.0	8.61	0.817950	0.2583
