/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 026_create_student_enrollment.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `student_enrollment` table to track student progression
               through semesters across academic sessions.
============================================================================
*/

CREATE TABLE IF NOT EXISTS student_enrollment (
    id                   SERIAL PRIMARY KEY,
    student_id           INTEGER NOT NULL,
    academic_session_id  INTEGER NOT NULL,
    semester             INTEGER NOT NULL,
    section_id           INTEGER NOT NULL,
    roll_number          VARCHAR(20),
    enrollment_date      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_enrollment_student FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fk_enrollment_academic_session FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE,
    CONSTRAINT fk_enrollment_section FOREIGN KEY (section_id) REFERENCES section(id) ON DELETE RESTRICT,
    CONSTRAINT unique_student_session_semester UNIQUE (student_id, academic_session_id, semester)
);

CREATE INDEX idx_enrollment_student_id ON student_enrollment (student_id);
CREATE INDEX idx_enrollment_academic_session_id ON student_enrollment (academic_session_id);
CREATE INDEX idx_enrollment_semester ON student_enrollment (semester);
CREATE INDEX idx_enrollment_section_id ON student_enrollment (section_id);

COMMENT ON TABLE student_enrollment IS 'Tracks student progression through semesters across academic sessions';
COMMENT ON COLUMN student_enrollment.student_id IS 'References student.id';
COMMENT ON COLUMN student_enrollment.academic_session_id IS 'References academic_session.id';
COMMENT ON COLUMN student_enrollment.semester IS 'Semester number (1-8)';
COMMENT ON COLUMN student_enrollment.section_id IS 'References section.id';
COMMENT ON COLUMN student_enrollment.roll_number IS 'Roll number for this specific enrollment';
COMMENT ON COLUMN student_enrollment.enrollment_date IS 'Date when enrollment was recorded';