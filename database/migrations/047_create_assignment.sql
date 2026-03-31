/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 047_create_assignment.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `assignment` table for homework/assignments given by teachers.
============================================================================
*/

CREATE TABLE IF NOT EXISTS assignment (
    id                   SERIAL PRIMARY KEY,
    title                VARCHAR(200) NOT NULL,
    description          TEXT,
    subject_id           INTEGER NOT NULL,
    course_id            INTEGER,
    semester             INTEGER,
    section_id           INTEGER,
    academic_session_id  INTEGER NOT NULL,
    due_date             DATE NOT NULL,
    max_marks            NUMERIC(5,2),
    created_by           INTEGER,
    created_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_assignment_subject FOREIGN KEY (subject_id) REFERENCES subject(id) ON DELETE CASCADE,
    CONSTRAINT fk_assignment_course FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE,
    CONSTRAINT fk_assignment_section FOREIGN KEY (section_id) REFERENCES section(id) ON DELETE CASCADE,
    CONSTRAINT fk_assignment_academic_session FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE,
    CONSTRAINT fk_assignment_created_by FOREIGN KEY (created_by) REFERENCES staff(id) ON DELETE SET NULL
);

CREATE INDEX idx_assignment_subject_id ON assignment (subject_id);
CREATE INDEX idx_assignment_course_id ON assignment (course_id);
CREATE INDEX idx_assignment_section_id ON assignment (section_id);
CREATE INDEX idx_assignment_academic_session_id ON assignment (academic_session_id);
CREATE INDEX idx_assignment_due_date ON assignment (due_date);

COMMENT ON TABLE assignment IS 'Homework/assignments created by teachers';
COMMENT ON COLUMN assignment.title IS 'Assignment title';
COMMENT ON COLUMN assignment.description IS 'Detailed description of the assignment';
COMMENT ON COLUMN assignment.subject_id IS 'References subject.id';
COMMENT ON COLUMN assignment.course_id IS 'References course.id (NULL if applicable to all courses)';
COMMENT ON COLUMN assignment.semester IS 'Semester number (NULL if applicable to all semesters)';
COMMENT ON COLUMN assignment.section_id IS 'References section.id (NULL if for all sections)';
COMMENT ON COLUMN assignment.academic_session_id IS 'References academic_session.id';
COMMENT ON COLUMN assignment.due_date IS 'Submission deadline';
COMMENT ON COLUMN assignment.max_marks IS 'Maximum marks for this assignment';
COMMENT ON COLUMN assignment.created_by IS 'References staff.id (teacher who created)';