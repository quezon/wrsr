GRANT ALL ON SCHEMA public TO wrsr;
ALTER SCHEMA public OWNER TO wrsr;

CREATE SCHEMA construction;
CREATE SCHEMA transportation;
CREATE SCHEMA production;

ALTER SCHEMA construction OWNER TO wrsr;
ALTER SCHEMA transportation OWNER TO wrsr;
ALTER SCHEMA production OWNER TO wrsr;

GRANT ALL ON SCHEMA construction TO wrsr;
GRANT ALL ON SCHEMA transportation TO wrsr;
GRANT ALL ON SCHEMA production TO wrsr;
