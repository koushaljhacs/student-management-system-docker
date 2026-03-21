/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 008_create_section.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-21
Description  : Creates the `section` table for academic sections/groups.
============================================================================
*/

CREATE TABLE IF NOT EXISTS section (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(10) UNIQUE NOT NULL,   -- e.g., A, B, C
    is_active   BOOLEAN DEFAULT TRUE,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_section_name ON section (name);
CREATE INDEX idx_section_is_active ON section (is_active);

COMMENT ON TABLE section IS 'Sections/groups within a course and semester (e.g., A, B, C)';
COMMENT ON COLUMN section.name IS 'Section name, unique';
COMMENT ON COLUMN section.is_active IS 'Whether the section is currently active';