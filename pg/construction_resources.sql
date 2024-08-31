CREATE OR REPLACE VIEW sample_construction_resources_needed AS
SELECT 
c.name,
b.construct_id,
b.resource,
desired_infra.qty_planned * qty total_qty
FROM (VALUES (1.0, 32), (2.0, 33), (3.0, 38)) AS desired_infra (qty_planned,construct_id)
inner join building_constructed_linear_costing b
on (desired_infra.construct_id = b.construct_id)
inner join building_constructed c
on (c.construct_id = b.construct_id)