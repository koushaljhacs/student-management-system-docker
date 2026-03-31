/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 038_create_hostel.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `hostel` table for hostel buildings.
============================================================================
*/

CREATE TABLE IF NOT EXISTS hostel (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    code        VARCHAR(20) UNIQUE NOT NULL,
    total_rooms INTEGER,
    description TEXT,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_hostel_code ON hostel (code);
CREATE INDEX idx_hostel_name ON hostel (name);

COMMENT ON TABLE hostel IS 'Hostel buildings';
COMMENT ON COLUMN hostel.name IS 'Name of the hostel (e.g., Boys Hostel, Girls Hostel)';
COMMENT ON COLUMN hostel.code IS 'Unique code for the hostel (e.g., BH-01, GH-01)';
COMMENT ON COLUMN hostel.total_rooms IS 'Total number of rooms in the hostel';
COMMENT ON COLUMN hostel.description IS 'Additional details about the hostel';