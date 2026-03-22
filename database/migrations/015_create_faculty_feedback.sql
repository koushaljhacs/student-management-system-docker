/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 015_create_faculty_feedback.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-22
Description  : Creates the `faculty_feedback` table for student feedback on faculty.
============================================================================
*/

CREATE TABLE IF NOT EXISTS faculty_feedback (
    id                   SERIAL PRIMARY KEY,
    student_id           INTEGER NOT NULL,
    staff_id             INTEGER NOT NULL,
    academic_session_id  INTEGER NOT NULL,
    semester             INTEGER NOT NULL,
    subject_id           INTEGER,
    rating               INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comments             TEXT,
    feedback_date        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_faculty_feedback_student FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fk_faculty_feedback_staff FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
    CONSTRAINT fk_faculty_feedback_academic_session FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE,
    CONSTRAINT fk_faculty_feedback_subject FOREIGN KEY (subject_id) REFERENCES subject(id) ON DELETE SET NULL,
    CONSTRAINT unique_faculty_feedback UNIQUE (student_id, staff_id, academic_session_id, semester, subject_id)
);

CREATE INDEX idx_faculty_feedback_student_id ON faculty_feedback (student_id);
CREATE INDEX idx_faculty_feedback_staff_id ON faculty_feedback (staff_id);
CREATE INDEX idx_faculty_feedback_academic_session_id ON faculty_feedback (academic_session_id);
CREATE INDEX idx_faculty_feedback_rating ON faculty_feedback (rating);

COMMENT ON TABLE faculty_feedback IS 'Student feedback for faculty members';
COMMENT ON COLUMN faculty_feedback.student_id IS 'References student.id';
COMMENT ON COLUMN faculty_feedback.staff_id IS 'References staff.id (faculty being rated)';
COMMENT ON COLUMN faculty_feedback.academic_session_id IS 'References academic_session.id';
COMMENT ON COLUMN faculty_feedback.semester IS 'Semester number';
COMMENT ON COLUMN faculty_feedback.subject_id IS 'Optional: specific subject being taught';
COMMENT ON COLUMN faculty_feedback.rating IS 'Rating from 1 to 5';
COMMENT ON COLUMN faculty_feedback.comments IS 'Optional text feedback';