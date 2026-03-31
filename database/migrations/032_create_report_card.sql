/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 032_create_report_card.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `report_card` table for semester-wise report cards.
============================================================================
*/

CREATE TABLE IF NOT EXISTS report_card (
    id                   SERIAL PRIMARY KEY,
    student_id           INTEGER NOT NULL,
    semester             INTEGER NOT NULL,
    academic_session_id  INTEGER NOT NULL,
    generated_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    file_url             TEXT,
    data                 JSONB,
    generated_by         INTEGER,
    CONSTRAINT fk_report_card_student FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fk_report_card_academic_session FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE,
    CONSTRAINT fk_report_card_generated_by FOREIGN KEY (generated_by) REFERENCES staff(id) ON DELETE SET NULL,
    CONSTRAINT unique_student_semester_session UNIQUE (student_id, semester, academic_session_id)
);

CREATE INDEX idx_report_card_student_id ON report_card (student_id);
CREATE INDEX idx_report_card_academic_session_id ON report_card (academic_session_id);
CREATE INDEX idx_report_card_semester ON report_card (semester);

COMMENT ON TABLE report_card IS 'Semester-wise report cards (summary or PDF)';
COMMENT ON COLUMN report_card.student_id IS 'References student.id';
COMMENT ON COLUMN report_card.semester IS 'Semester number (1-8)';
COMMENT ON COLUMN report_card.academic_session_id IS 'References academic_session.id';
COMMENT ON COLUMN report_card.generated_at IS 'Timestamp when report card was generated';
COMMENT ON COLUMN report_card.file_url IS 'URL to the PDF file (if generated)';
COMMENT ON COLUMN report_card.data IS 'Structured JSON data of the report card';
COMMENT ON COLUMN report_card.generated_by IS 'References staff.id (who generated the report)';