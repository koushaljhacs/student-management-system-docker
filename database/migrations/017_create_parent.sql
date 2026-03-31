/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 017_create_parent.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `parent` table for parent/guardian profiles.
               No student_id here - relationship via student_guardian table.
============================================================================
*/

CREATE TABLE IF NOT EXISTS parent (
    id             SERIAL PRIMARY KEY,
    name           VARCHAR(100) NOT NULL,
    phone          VARCHAR(15) UNIQUE,
    address        TEXT,
    occupation     VARCHAR(100),
    annual_income  NUMERIC(12,2),
    photo_url      TEXT,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at     TIMESTAMP
);

CREATE INDEX idx_parent_phone ON parent (phone);
CREATE INDEX idx_parent_deleted_at ON parent (deleted_at) WHERE deleted_at IS NULL;

COMMENT ON TABLE parent IS 'Parent/guardian profiles. Authentication handled by users table.';
COMMENT ON COLUMN parent.name IS 'Full name of parent/guardian';
COMMENT ON COLUMN parent.phone IS 'Contact number (unique)';
COMMENT ON COLUMN parent.address IS 'Residential address';
COMMENT ON COLUMN parent.occupation IS 'Profession of parent';
COMMENT ON COLUMN parent.annual_income IS 'Annual income for scholarship/fee concession evaluation';
COMMENT ON COLUMN parent.photo_url IS 'Profile picture URL';
COMMENT ON COLUMN parent.deleted_at IS 'Soft delete timestamp';