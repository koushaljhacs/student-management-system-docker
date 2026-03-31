/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 048_create_submission.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `submission` table for student submissions to assignments.
============================================================================
*/

CREATE TABLE IF NOT EXISTS submission (
    id             SERIAL PRIMARY KEY,
    assignment_id  INTEGER NOT NULL,
    student_id     INTEGER NOT NULL,
    submitted_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    file_url       TEXT,
    marks_obtained NUMERIC(5,2),
    feedback       TEXT,
    status         VARCHAR(20) DEFAULT 'Submitted' CHECK (status IN ('Submitted', 'Late', 'Graded')),
    graded_by      INTEGER,
    CONSTRAINT fk_submission_assignment FOREIGN KEY (assignment_id) REFERENCES assignment(id) ON DELETE CASCADE,
    CONSTRAINT fk_submission_student FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fk_submission_graded_by FOREIGN KEY (graded_by) REFERENCES staff(id) ON DELETE SET NULL,
    CONSTRAINT unique_assignment_student UNIQUE (assignment_id, student_id)
);

CREATE INDEX idx_submission_assignment_id ON submission (assignment_id);
CREATE INDEX idx_submission_student_id ON submission (student_id);
CREATE INDEX idx_submission_status ON submission (status);
CREATE INDEX idx_submission_submitted_at ON submission (submitted_at);

COMMENT ON TABLE submission IS 'Student submissions for assignments';
COMMENT ON COLUMN submission.assignment_id IS 'References assignment.id';
COMMENT ON COLUMN submission.student_id IS 'References student.id';
COMMENT ON COLUMN submission.submitted_at IS 'Timestamp when submission was made';
COMMENT ON COLUMN submission.file_url IS 'URL to uploaded file';
COMMENT ON COLUMN submission.marks_obtained IS 'Marks awarded by teacher';
COMMENT ON COLUMN submission.feedback IS 'Teacher feedback/comments';
COMMENT ON COLUMN submission.status IS 'Submission status: Submitted, Late, Graded';
COMMENT ON COLUMN submission.graded_by IS 'References staff.id (teacher who graded)';