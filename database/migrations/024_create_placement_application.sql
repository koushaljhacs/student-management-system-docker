/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 024_create_placement_application.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `placement_application` table for student applications
               to placement drives.
============================================================================
*/

CREATE TABLE IF NOT EXISTS placement_application (
    id                  SERIAL PRIMARY KEY,
    student_id          INTEGER NOT NULL,
    placement_drive_id  INTEGER NOT NULL,
    application_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status              VARCHAR(20) DEFAULT 'Applied' CHECK (status IN ('Applied','Shortlisted','Selected','Rejected')),
    remarks             TEXT,
    CONSTRAINT fk_placement_app_student FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fk_placement_app_drive FOREIGN KEY (placement_drive_id) REFERENCES placement_drive(id) ON DELETE CASCADE,
    CONSTRAINT unique_student_drive UNIQUE (student_id, placement_drive_id)
);

CREATE INDEX idx_placement_app_student_id ON placement_application (student_id);
CREATE INDEX idx_placement_app_drive_id ON placement_application (placement_drive_id);
CREATE INDEX idx_placement_app_status ON placement_application (status);

COMMENT ON TABLE placement_application IS 'Student applications to placement drives';
COMMENT ON COLUMN placement_application.student_id IS 'References student.id';
COMMENT ON COLUMN placement_application.placement_drive_id IS 'References placement_drive.id';
COMMENT ON COLUMN placement_application.status IS 'Application status: Applied, Shortlisted, Selected, Rejected';
COMMENT ON COLUMN placement_application.remarks IS 'Additional notes about the application';