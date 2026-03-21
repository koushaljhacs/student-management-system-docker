/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 005_create_course.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-21
Description  : Creates the `course` table for academic courses.
============================================================================
*/

CREATE TABLE IF NOT EXISTS course (
    id             SERIAL PRIMARY KEY,
    name           VARCHAR(100) NOT NULL,
    code           VARCHAR(20) UNIQUE NOT NULL,
    description    TEXT,
    duration_years INTEGER,
    is_active      BOOLEAN DEFAULT TRUE,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_course_code ON course (code);
CREATE INDEX idx_course_is_active ON course (is_active);

COMMENT ON TABLE course IS 'Academic courses offered (e.g., B.Tech CSE)';
COMMENT ON COLUMN course.name IS 'Full course name';
COMMENT ON COLUMN course.code IS 'Unique course code';
COMMENT ON COLUMN course.duration_years IS 'Number of years for the course';
COMMENT ON COLUMN course.is_active IS 'Whether the course is currently offered';