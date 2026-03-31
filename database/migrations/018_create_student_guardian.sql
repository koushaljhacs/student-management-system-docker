/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 018_create_student_guardian.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `student_guardian` junction table for many-to-many
               relationship between students and parents/guardians.
============================================================================
*/

CREATE TABLE IF NOT EXISTS student_guardian (
    id                   SERIAL PRIMARY KEY,
    student_id           INTEGER NOT NULL,
    parent_id            INTEGER NOT NULL,
    relation_to_student  VARCHAR(50),
    is_primary           BOOLEAN DEFAULT FALSE,
    created_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_student_guardian_student FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fk_student_guardian_parent FOREIGN KEY (parent_id) REFERENCES parent(id) ON DELETE CASCADE,
    CONSTRAINT unique_student_parent UNIQUE (student_id, parent_id)
);

CREATE INDEX idx_student_guardian_student_id ON student_guardian (student_id);
CREATE INDEX idx_student_guardian_parent_id ON student_guardian (parent_id);
CREATE INDEX idx_student_guardian_is_primary ON student_guardian (is_primary);

COMMENT ON TABLE student_guardian IS 'Many-to-many link between students and parents/guardians';
COMMENT ON COLUMN student_guardian.student_id IS 'References student.id';
COMMENT ON COLUMN student_guardian.parent_id IS 'References parent.id';
COMMENT ON COLUMN student_guardian.relation_to_student IS 'e.g., Father, Mother, Guardian';
COMMENT ON COLUMN student_guardian.is_primary IS 'Whether this is the primary contact for the student';