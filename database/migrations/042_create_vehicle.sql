/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 042_create_vehicle.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `vehicle` table for vehicles (buses) assigned to routes.
============================================================================
*/

CREATE TABLE IF NOT EXISTS vehicle (
    id             SERIAL PRIMARY KEY,
    vehicle_number VARCHAR(20) UNIQUE NOT NULL,
    type           VARCHAR(50),
    capacity       INTEGER,
    route_id       INTEGER,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_vehicle_route FOREIGN KEY (route_id) REFERENCES transport_route(id) ON DELETE SET NULL
);

CREATE INDEX idx_vehicle_number ON vehicle (vehicle_number);
CREATE INDEX idx_vehicle_route_id ON vehicle (route_id);
CREATE INDEX idx_vehicle_type ON vehicle (type);

COMMENT ON TABLE vehicle IS 'Vehicles (buses) assigned to transport routes';
COMMENT ON COLUMN vehicle.vehicle_number IS 'Registration number of the vehicle (unique)';
COMMENT ON COLUMN vehicle.type IS 'Vehicle type (e.g., Bus, Mini-Bus, Van)';
COMMENT ON COLUMN vehicle.capacity IS 'Maximum passenger capacity';
COMMENT ON COLUMN vehicle.route_id IS 'References transport_route.id (currently assigned route)';