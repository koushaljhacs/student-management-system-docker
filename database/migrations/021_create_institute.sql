/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 021_create_institute.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `institute` table for storing educational institute details.
               This table should contain a single record.
============================================================================
*/

CREATE TABLE IF NOT EXISTS institute (
    id               SERIAL PRIMARY KEY,
    name             VARCHAR(200) NOT NULL,
    short_name       VARCHAR(50),
    logo_url         TEXT,
    address          TEXT,
    phone            VARCHAR(20),
    email            VARCHAR(100),
    website          VARCHAR(200),
    established_year INTEGER,
    affiliation      VARCHAR(200),
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_institute_name ON institute (name);

COMMENT ON TABLE institute IS 'Educational institute details (single record)';
COMMENT ON COLUMN institute.name IS 'Full name of the institute';
COMMENT ON COLUMN institute.short_name IS 'Short name/abbreviation';
COMMENT ON COLUMN institute.logo_url IS 'URL to institute logo';
COMMENT ON COLUMN institute.address IS 'Physical address of the institute';
COMMENT ON COLUMN institute.phone IS 'Contact phone number';
COMMENT ON COLUMN institute.email IS 'Contact email';
COMMENT ON COLUMN institute.website IS 'Official website URL';
COMMENT ON COLUMN institute.established_year IS 'Year of establishment';
COMMENT ON COLUMN institute.affiliation IS 'University or board affiliation';