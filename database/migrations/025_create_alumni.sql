/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 025_create_alumni.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `alumni` table for alumni-specific data.
               Students become alumni after graduation.
============================================================================
*/

CREATE TABLE IF NOT EXISTS alumni (
    id               SERIAL PRIMARY KEY,
    student_id       INTEGER NOT NULL UNIQUE,
    graduation_year  INTEGER,
    current_company  VARCHAR(200),
    current_position VARCHAR(200),
    contact_email    VARCHAR(100),
    contact_phone    VARCHAR(15),
    updated_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_alumni_student FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE
);

CREATE INDEX idx_alumni_student_id ON alumni (student_id);
CREATE INDEX idx_alumni_graduation_year ON alumni (graduation_year);
CREATE INDEX idx_alumni_current_company ON alumni (current_company);

COMMENT ON TABLE alumni IS 'Alumni records for graduated students';
COMMENT ON COLUMN alumni.student_id IS 'References original student.id';
COMMENT ON COLUMN alumni.graduation_year IS 'Year of graduation';
COMMENT ON COLUMN alumni.current_company IS 'Company where alumni currently works';
COMMENT ON COLUMN alumni.current_position IS 'Job position/title';
COMMENT ON COLUMN alumni.contact_email IS 'Alumni contact email (can differ from student email)';
COMMENT ON COLUMN alumni.contact_phone IS 'Alumni contact phone';