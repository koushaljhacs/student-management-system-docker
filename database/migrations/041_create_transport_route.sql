/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 041_create_transport_route.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `transport_route` table for bus routes.
============================================================================
*/

CREATE TABLE IF NOT EXISTS transport_route (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    route_code  VARCHAR(20) UNIQUE NOT NULL,
    start_point VARCHAR(100),
    end_point   VARCHAR(100),
    distance_km NUMERIC(6,2),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_transport_route_code ON transport_route (route_code);
CREATE INDEX idx_transport_route_name ON transport_route (name);

COMMENT ON TABLE transport_route IS 'Bus routes for transport management';
COMMENT ON COLUMN transport_route.name IS 'Route name (e.g., North Campus Route)';
COMMENT ON COLUMN transport_route.route_code IS 'Unique code for the route (e.g., R-101)';
COMMENT ON COLUMN transport_route.start_point IS 'Starting point of the route';
COMMENT ON COLUMN transport_route.end_point IS 'End point of the route';
COMMENT ON COLUMN transport_route.distance_km IS 'Total distance in kilometers';