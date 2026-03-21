/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 007_create_academic_session.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-21
Description  : Creates the `academic_session` table for academic years/sessions.
============================================================================
*/

CREATE TABLE IF NOT EXISTS academic_session (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(50) UNIQUE NOT NULL,     -- e.g., "2025-2026"
    start_date  DATE NOT NULL,
    end_date    DATE NOT NULL,
    is_active   BOOLEAN DEFAULT FALSE,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_academic_session_name ON academic_session (name);
CREATE INDEX idx_academic_session_is_active ON academic_session (is_active);
CREATE INDEX idx_academic_session_dates ON academic_session (start_date, end_date);

COMMENT ON TABLE academic_session IS 'Academic years/sessions (e.g., 2025-2026)';
COMMENT ON COLUMN academic_session.name IS 'Session name, unique';
COMMENT ON COLUMN academic_session.start_date IS 'Start date of the session';
COMMENT ON COLUMN academic_session.end_date IS 'End date of the session';
COMMENT ON COLUMN academic_session.is_active IS 'Whether this is the current active session';