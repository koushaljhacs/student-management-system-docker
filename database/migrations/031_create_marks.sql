/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 031_create_marks.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `marks` table for storing student marks per subject,
               exam type, session, and semester.
============================================================================
*/

CREATE TABLE IF NOT EXISTS marks (
    id                   SERIAL PRIMARY KEY,
    student_id           INTEGER NOT NULL,
    subject_id           INTEGER NOT NULL,
    exam_type_id         INTEGER NOT NULL,
    academic_session_id  INTEGER NOT NULL,
    semester             INTEGER NOT NULL,
    marks_obtained       NUMERIC(5,2) NOT NULL,
    max_marks            NUMERIC(5,2) NOT NULL,
    grade                VARCHAR(2),
    remarks              TEXT,
    recorded_by          INTEGER,
    recorded_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_marks_student FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fk_marks_subject FOREIGN KEY (subject_id) REFERENCES subject(id) ON DELETE CASCADE,
    CONSTRAINT fk_marks_exam_type FOREIGN KEY (exam_type_id) REFERENCES exam_type(id) ON DELETE CASCADE,
    CONSTRAINT fk_marks_academic_session FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE,
    CONSTRAINT fk_marks_recorded_by FOREIGN KEY (recorded_by) REFERENCES staff(id) ON DELETE SET NULL,
    CONSTRAINT unique_student_subject_exam UNIQUE (student_id, subject_id, exam_type_id, academic_session_id, semester)
);

CREATE INDEX idx_marks_student_id ON marks (student_id);
CREATE INDEX idx_marks_subject_id ON marks (subject_id);
CREATE INDEX idx_marks_exam_type_id ON marks (exam_type_id);
CREATE INDEX idx_marks_academic_session_id ON marks (academic_session_id);
CREATE INDEX idx_marks_semester ON marks (semester);

COMMENT ON TABLE marks IS 'Marks obtained by students per subject, exam type, session, and semester';
COMMENT ON COLUMN marks.student_id IS 'References student.id';
COMMENT ON COLUMN marks.subject_id IS 'References subject.id';
COMMENT ON COLUMN marks.exam_type_id IS 'References exam_type.id';
COMMENT ON COLUMN marks.academic_session_id IS 'References academic_session.id';
COMMENT ON COLUMN marks.semester IS 'Semester number (1-8)';
COMMENT ON COLUMN marks.marks_obtained IS 'Marks scored by the student';
COMMENT ON COLUMN marks.max_marks IS 'Maximum possible marks';
COMMENT ON COLUMN marks.grade IS 'Grade awarded (e.g., A, B+, etc.)';
COMMENT ON COLUMN marks.recorded_by IS 'References staff.id (who entered the marks)';