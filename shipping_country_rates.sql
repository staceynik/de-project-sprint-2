drop table if exists shipping_country_rates cascade;
CREATE TABLE shipping_country_rates (
    id SERIAL PRIMARY KEY,
    shipping_country TEXT,
    shipping_country_base_rate NUMERIC
);


INSERT INTO shipping_country_rates (shipping_country, shipping_country_base_rate)
SELECT DISTINCT shipping_country, shipping_country_base_rate 
FROM shipping
WHERE shipping_country IS NOT NULL AND shipping_country_base_rate IS NOT NULL;


-- Проверка содержимого таблицы

select * from shipping_country_rates limit 10;

1	usa	0.020
2	norway	0.040
3	germany	0.010
4	russia	0.030
