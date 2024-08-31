CREATE OR REPLACE VIEW construction.required_resources_for_each_item AS
SELECT 
c.name,
b.construct_id,
b.resource,
desired_infra.qty_planned * qty total_qty
FROM (VALUES (1.0, 32), (2.0, 33), (3.0, 38)) AS desired_infra (qty_planned,construct_id)
inner join public.building_constructed_linear_costing b
on (desired_infra.construct_id = b.construct_id)
inner join public.building_constructed c
on (c.construct_id = b.construct_id);

COMMENT ON VIEW construction.required_resources_for_each_item
    IS 'Qty Planned | Contruct Name
1.0 | Bus End Station (Large)
2.0 | Bus End Station (Small)
3.0 | Tram End Station
';

CREATE OR REPLACE VIEW construction.all_required_resources_for_the_items AS
SELECT resource, SUM(total_qty) AS total_qty FROM construction.required_resources_for_each_item
GROUP BY resource;

COMMENT ON VIEW construction.all_required_resources_for_the_items
    IS 'Total resource requirements for Bus End Station (Large), Bus End Station (Large), and Tram End Station';