drop table if exists shipping_info;
CREATE TABLE shipping_info (
    shipping_id BIGINT PRIMARY KEY, 
    shipping_country_rate_id INT, 
    shipping_agreement_id INT, 
    shipping_transfer_id INT, 
    shipping_plan_datetime TIMESTAMP WITHOUT TIME ZONE, 
    payment_amount NUMERIC, -- Сумма платежа
    vendor_id BIGINT, -- Идентификатор вендора
    FOREIGN KEY (shipping_country_rate_id) REFERENCES shipping_country_rates(id), 
    FOREIGN KEY (shipping_agreement_id) REFERENCES shipping_agreement(agreement_id),
    FOREIGN KEY (shipping_transfer_id) REFERENCES shipping_transfer(id) 
);



INSERT INTO shipping_info (shipping_id, vendor_id, payment_amount, shipping_plan_datetime, shipping_transfer_id, shipping_agreement_id, shipping_country_rate_id)
SELECT DISTINCT
    s.shipping_id,
    s.vendor_id,
    s.payment_amount,
    s.shipping_plan_datetime,
    st.id AS shipping_transfer_id,
    CAST((regexp_split_to_array(s.vendor_agreement_description, E'\\:+'))[1] AS BIGINT) AS shipping_agreement_id,
    scr.id AS shipping_country_rate_id
FROM 
    shipping AS s
LEFT JOIN 
    shipping_transfer AS st ON (regexp_split_to_array(s.shipping_transfer_description, E'\\:+'))[1] = st.transfer_type
    AND (regexp_split_to_array(s.shipping_transfer_description, E'\\:+'))[2] = st.transfer_model
LEFT JOIN 
    shipping_country_rates AS scr ON s.shipping_country = scr.shipping_country
ON CONFLICT (shipping_id) 
DO NOTHING;

-- Checking Table Contents

SELECT COUNT(*) FROM shipping_info;

54.174

SELECT * FROM shipping_info limit 10;

27644	3	2	4	2021-12-09 05:27:52.573	14.62	1
44289	4	5	3	2022-03-05 00:02:01.752	1.68	3
10240	2	11	4	2021-11-18 05:31:50.957	1.59	2
40770	3	9	4	2022-04-19 15:16:09.802	6.19	2
33510	4	10	4	2022-01-24 18:04:51.696	2.14	2
26973	1	6	3	2021-11-09 17:11:50.194	1.79	3
49131	2	7	4	2022-05-09 11:12:54.347	6.32	3
31277	1	5	4	2022-02-01 22:17:54.457	3.58	3
14257	2	7	4	2021-10-18 19:01:53.590	9.78	3
12732	3	9	4	2021-09-14 17:05:48.521	16.73	2
