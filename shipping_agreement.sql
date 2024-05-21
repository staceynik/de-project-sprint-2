drop table if exists shipping_agreement cascade;
CREATE TABLE shipping_agreement (
    agreement_id INT PRIMARY KEY,
    agreement_number TEXT,
    agreement_rate NUMERIC,
    agreement_commission NUMERIC
);

INSERT INTO shipping_agreement (agreement_id, agreement_number, agreement_rate, agreement_commission)
SELECT 
    CAST((regexp_split_to_array(vendor_agreement_description, ':'))[1] AS INT),
    (regexp_split_to_array(vendor_agreement_description, ':'))[2],
    CAST((regexp_split_to_array(vendor_agreement_description, ':'))[3] AS NUMERIC),
    CAST((regexp_split_to_array(vendor_agreement_description, ':'))[4] AS NUMERIC)
FROM 
    shipping
ON CONFLICT (agreement_id) 
DO NOTHING;

-- Checking Table Contents

SELECT COUNT(*) FROM shipping_agreement;

60

select * from shipping_agreement limit 10;

0	vspn-4092	0.14	0.02
1	vspn-366	0.13	0.01
2	vspn-4148	0.01	0.01
3	vspn-3023	0.05	0.01
4	vspn-1909	0.03	0.03
5	vspn-7339	0.04	0.03
6	vspn-4215	0.04	0.01
7	vspn-1005	0.08	0.02
8	vspn-8118	0.11	0.02
9	vspn-675	0.15	0.03
