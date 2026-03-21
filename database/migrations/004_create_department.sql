/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 004_create_department.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-21
Description  : Creates the `department` table.
============================================================================
*/

CREATE TABLE IF NOT EXISTS department (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    is_active   BOOLEAN DEFAULT TRUE,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_department_name ON department (name);
CREATE INDEX idx_department_is_active ON department (is_active);

COMMENT ON TABLE department IS 'Organisational departments (e.g., CSE, ECE, Mechanical)';
COMMENT ON COLUMN department.name IS 'Unique department name';
COMMENT ON COLUMN department.description IS 'Brief description of the department';
COMMENT ON COLUMN department.is_active IS 'Soft disable flag for department';