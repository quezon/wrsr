DROP VIEW IF EXISTS production.producers_max_workers CASCADE;
DROP VIEW IF EXISTS production.production_resource_input_daily_max CASCADE;
DROP VIEW IF EXISTS production.production_resource_output_daily_max CASCADE;

CREATE OR REPLACE VIEW production.producers_max_workers AS
SELECT b.producer_id, b.producer, a.worker_type, a.number_of_workers, b.is_vanilla FROM public.producers_max_workers a
INNER JOIN public.producers b 
ON (a.producer_id = b.producer_id)
WHERE a.number_of_workers IS NOT NULL;

CREATE OR REPLACE VIEW production.production_resource_input_daily_max AS
SELECT b.producer_id, b.producer, a.input_qty FROM public.production_resource_input_daily_max a
INNER JOIN public.producers b 
ON (a.producer_id = b.producer_id);

CREATE OR REPLACE VIEW production.production_resource_output_daily_max AS
SELECT b.producer_id, b.producer, a.output_qty FROM public.production_resource_output_daily_max a
INNER JOIN public.producers b 
ON (a.producer_id = b.producer_id);