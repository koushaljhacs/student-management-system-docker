/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 052_create_student_event.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `student_event` table for student participation in events.
============================================================================
*/

CREATE TABLE IF NOT EXISTS student_event (
    id                 SERIAL PRIMARY KEY,
    student_id         INTEGER NOT NULL,
    event_id           INTEGER NOT NULL,
    registration_date  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    attendance_status  VARCHAR(20) DEFAULT 'Registered' CHECK (attendance_status IN ('Registered', 'Attended', 'Absent')),
    remarks            TEXT,
    CONSTRAINT fk_student_event_student FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fk_student_event_event FOREIGN KEY (event_id) REFERENCES event(id) ON DELETE CASCADE,
    CONSTRAINT unique_student_event UNIQUE (student_id, event_id)
);

CREATE INDEX idx_student_event_student_id ON student_event (student_id);
CREATE INDEX idx_student_event_event_id ON student_event (event_id);
CREATE INDEX idx_student_event_attendance_status ON student_event (attendance_status);

COMMENT ON TABLE student_event IS 'Records student participation in events';
COMMENT ON COLUMN student_event.student_id IS 'References student.id';
COMMENT ON COLUMN student_event.event_id IS 'References event.id';
COMMENT ON COLUMN student_event.registration_date IS 'Date when student registered for the event';
COMMENT ON COLUMN student_event.attendance_status IS 'Status: Registered, Attended, Absent';
COMMENT ON COLUMN student_event.remarks IS 'Additional notes about participation';