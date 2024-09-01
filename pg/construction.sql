DROP VIEW IF EXISTS construction.required_resources_for_each_item CASCADE;
DROP VIEW IF EXISTS construction.all_required_resources_for_the_items CASCADE;
DROP VIEW IF EXISTS construction.estimated_road_resource_cost CASCADE;

CREATE OR REPLACE VIEW construction.required_resources_for_each_item AS
SELECT 
c.name,
b.construct_id,
b.resource,
round(cast(planned_bldg.qty_planned * b.qty as numeric),3) total_resource_qty
FROM (VALUES (1.0, 32), (2.0, 33), (3.0, 38)) AS planned_bldg (qty_planned,construct_id)
inner join public.construction_linear_costing b
on (planned_bldg.construct_id = b.construct_id)
inner join public.construction c
on (c.construct_id = b.construct_id);

COMMENT ON VIEW construction.required_resources_for_each_item
    IS 'Qty Planned | Contruct Name
1.0 | Bus End Station (Large)
2.0 | Bus End Station (Small)
3.0 | Tram End Station
';

CREATE OR REPLACE VIEW construction.all_required_resources_for_the_items AS
SELECT resource, SUM(cast(total_resource_qty as numeric)) AS total_qty FROM construction.required_resources_for_each_item
GROUP BY resource;

COMMENT ON VIEW construction.all_required_resources_for_the_items
    IS 'Total resource requirements for Bus End Station (Large), Bus End Station (Large), and Tram End Station';
	
CREATE OR REPLACE VIEW construction.estimated_road_resource_cost AS
SELECT 
c.name,
b.construct_id,
b.resource,
planned_road.meters as length_meters,
round(cast(planned_road.meters / c.smallest_unit * b.qty as numeric),3) total_resource_qty
FROM (VALUES (30.0, 2), (42.0, 5)) AS planned_road (meters,construct_id)
inner join public.construction_linear_costing b
on (planned_road.construct_id = b.construct_id)
inner join public.construction c
on (c.construct_id = b.construct_id);