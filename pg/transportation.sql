DROP VIEW IF EXISTS transportation.transportation_build_resource_requirements CASCADE;
DROP VIEW IF EXISTS transportation.transportation_cargo_capacity CASCADE;
DROP VIEW IF EXISTS transportation.transportation_passenger_capacity CASCADE;

CREATE OR REPLACE VIEW transportation.transportation_build_resource_requirements AS
SELECT b.producer_id, b.producer, a.blueprint_id, b.name, a.resource, a.qty FROM public.transportation_build_resource_requirements a
INNER JOIN public.transportation b 
ON (a.blueprint_id = b.blueprint_id);

--- Cargo resource capacities are not meant to be added to arrive at the total capacity of a transporter
--- Multiply by percentage of resource to the capacity qty to arrive at capacity limit
--- For example:
--- Using blueprint_id: 1, name: "AN12"
--- 50% Alcohol  --> Max Capacity: 11 tons * 50% = 5.5 tons of Alcohol
--- 50% Aluminum --> Max Capacity: 22 * 50% = 11 tons of Aluminum
CREATE OR REPLACE VIEW transportation.transportation_cargo_capacity AS
SELECT b.producer_id, b.producer, a.blueprint_id, b.name, a.resource, a.qty FROM public.transportation_cargo_capacity a
INNER JOIN public.transportation b 
ON (a.blueprint_id = b.blueprint_id);

CREATE OR REPLACE VIEW transportation.transportation_passenger_capacity AS
SELECT b.producer_id, b.producer, a.blueprint_id, b.name, a.passenger_capacity FROM public.transportation_passenger_capacity a
INNER JOIN public.transportation b 
ON (a.blueprint_id = b.blueprint_id);