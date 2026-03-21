/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 002_create_permission.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-21
Description  : Creates the `permission` table.
============================================================================
*/

CREATE TABLE IF NOT EXISTS permission (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(50) UNIQUE NOT NULL,      -- e.g., "student.view"
    description TEXT,                              -- Human-readable description
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_permission_name ON permission (name);

COMMENT ON TABLE permission IS 'Stores granular permissions for RBAC';
COMMENT ON COLUMN permission.name IS 'Unique permission identifier, e.g., "student.view"';
COMMENT ON COLUMN permission.description IS 'Human-readable description of what this permission grants';