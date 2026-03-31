/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 027_create_student_subject_registration.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `student_subject_registration` table for explicit
               subject enrollment per student, session, and semester.
============================================================================
*/

CREATE TABLE IF NOT EXISTS student_subject_registration (
    id                   SERIAL PRIMARY KEY,
    student_id           INTEGER NOT NULL,
    subject_id           INTEGER NOT NULL,
    academic_session_id  INTEGER NOT NULL,
    semester             INTEGER NOT NULL,
    registration_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status               VARCHAR(20) DEFAULT 'Active' CHECK (status IN ('Active', 'Dropped')),
    CONSTRAINT fk_reg_student FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fk_reg_subject FOREIGN KEY (subject_id) REFERENCES subject(id) ON DELETE CASCADE,
    CONSTRAINT fk_reg_academic_session FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE,
    CONSTRAINT unique_student_subject_session UNIQUE (student_id, subject_id, academic_session_id, semester)
);

CREATE INDEX idx_reg_student_id ON student_subject_registration (student_id);
CREATE INDEX idx_reg_subject_id ON student_subject_registration (subject_id);
CREATE INDEX idx_reg_academic_session_id ON student_subject_registration (academic_session_id);
CREATE INDEX idx_reg_status ON student_subject_registration (status);

COMMENT ON TABLE student_subject_registration IS 'Explicit subject registration per student, session, and semester';
COMMENT ON COLUMN student_subject_registration.student_id IS 'References student.id';
COMMENT ON COLUMN student_subject_registration.subject_id IS 'References subject.id';
COMMENT ON COLUMN student_subject_registration.academic_session_id IS 'References academic_session.id';
COMMENT ON COLUMN student_subject_registration.semester IS 'Semester number (1-8)';
COMMENT ON COLUMN student_subject_registration.registration_date IS 'When the subject was registered';
COMMENT ON COLUMN student_subject_registration.status IS 'Active or Dropped (for add/drop functionality)';