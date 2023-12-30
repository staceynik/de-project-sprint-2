drop table if exists shipping_transfer cascade;
CREATE TABLE shipping_transfer (
    id SERIAL PRIMARY KEY, 
    transfer_type TEXT,
    transfer_model TEXT, 
    shipping_transfer_rate NUMERIC(14, 4) 
);

INSERT INTO shipping_transfer (transfer_type, transfer_model, shipping_transfer_rate)
SELECT DISTINCT
    (regexp_split_to_array(shipping_transfer_description, ':'))[1], 
    (regexp_split_to_array(shipping_transfer_description, ':'))[2], 
    shipping_transfer_rate
FROM 
    shipping;

-- Проверка содержимого таблицы

SELECT COUNT(*) FROM shipping_transfer;

8

SELECT * FROM shipping_transfer limit 10;

1	3p	multiplie	0.0450
2	3p	train	        0.0200
3	1p	ship	        0.0300
4	1p	airplane	0.0400
5	1p	train	        0.0250
6	1p	multiplie	0.0500
7	3p	ship	        0.0250
8	3p	airplane	0.0350
