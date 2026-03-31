/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 023_create_placement_drive.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `placement_drive` table for placement drives/events.
============================================================================
*/

CREATE TABLE IF NOT EXISTS placement_drive (
    id          SERIAL PRIMARY KEY,
    company_name VARCHAR(200) NOT NULL,
    drive_date  DATE,
    description TEXT,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_placement_drive_company ON placement_drive (company_name);
CREATE INDEX idx_placement_drive_date ON placement_drive (drive_date);

COMMENT ON TABLE placement_drive IS 'Records of placement drives/events';
COMMENT ON COLUMN placement_drive.company_name IS 'Name of the recruiting company';
COMMENT ON COLUMN placement_drive.drive_date IS 'Date of the placement drive';
COMMENT ON COLUMN placement_drive.description IS 'Additional details about the drive';