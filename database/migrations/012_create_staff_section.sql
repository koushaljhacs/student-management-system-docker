/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 012_create_staff_section.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-22
Description  : Creates the `staff_section` table for faculty section allotment.
============================================================================
*/

CREATE TABLE IF NOT EXISTS staff_section (
    id                   SERIAL PRIMARY KEY,
    staff_id             INTEGER NOT NULL,
    section_id           INTEGER NOT NULL,
    academic_session_id  INTEGER NOT NULL,
    semester             INTEGER NOT NULL,
    assigned_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_staff_section_staff FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
    CONSTRAINT fk_staff_section_section FOREIGN KEY (section_id) REFERENCES section(id) ON DELETE CASCADE,
    CONSTRAINT fk_staff_section_academic_session FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE,
    CONSTRAINT unique_staff_section UNIQUE (staff_id, section_id, academic_session_id, semester)
);

CREATE INDEX idx_staff_section_staff_id ON staff_section (staff_id);
CREATE INDEX idx_staff_section_section_id ON staff_section (section_id);
CREATE INDEX idx_staff_section_academic_session_id ON staff_section (academic_session_id);
CREATE INDEX idx_staff_section_semester ON staff_section (semester);

COMMENT ON TABLE staff_section IS 'Faculty section allotment for a given session and semester';
COMMENT ON COLUMN staff_section.staff_id IS 'References staff.id (the faculty member)';
COMMENT ON COLUMN staff_section.section_id IS 'References section.id';
COMMENT ON COLUMN staff_section.academic_session_id IS 'References academic_session.id';
COMMENT ON COLUMN staff_section.semester IS 'Semester number (1-8)';
COMMENT ON COLUMN staff_section.assigned_at IS 'Timestamp when the allotment was created';