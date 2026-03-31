/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 034_create_fee_structure.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `fee_structure` table for defining fee types.
============================================================================
*/

CREATE TABLE IF NOT EXISTS fee_structure (
    id                   SERIAL PRIMARY KEY,
    name                 VARCHAR(100) NOT NULL,
    course_id            INTEGER,
    semester             INTEGER,
    academic_session_id  INTEGER NOT NULL,
    amount               NUMERIC(12,2) NOT NULL,
    tax_percentage       NUMERIC(5,2) DEFAULT 0,
    due_date             DATE,
    description          TEXT,
    created_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_fee_structure_course FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE,
    CONSTRAINT fk_fee_structure_academic_session FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE
);

CREATE INDEX idx_fee_structure_course_id ON fee_structure (course_id);
CREATE INDEX idx_fee_structure_semester ON fee_structure (semester);
CREATE INDEX idx_fee_structure_academic_session_id ON fee_structure (academic_session_id);
CREATE INDEX idx_fee_structure_due_date ON fee_structure (due_date);

COMMENT ON TABLE fee_structure IS 'Defines fee types for a course, semester, and session';
COMMENT ON COLUMN fee_structure.name IS 'Fee type name (e.g., Tuition Fee, Hostel Fee)';
COMMENT ON COLUMN fee_structure.course_id IS 'References course.id (NULL if applicable to all courses)';
COMMENT ON COLUMN fee_structure.semester IS 'Semester number (NULL if annual fee)';
COMMENT ON COLUMN fee_structure.academic_session_id IS 'References academic_session.id';
COMMENT ON COLUMN fee_structure.amount IS 'Base fee amount';
COMMENT ON COLUMN fee_structure.tax_percentage IS 'Tax percentage to be applied';
COMMENT ON COLUMN fee_structure.due_date IS 'Due date for this fee';