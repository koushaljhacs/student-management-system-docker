/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 033_create_attendance.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `attendance` table for subject-wise daily attendance records.
============================================================================
*/

CREATE TABLE IF NOT EXISTS attendance (
    id                   SERIAL PRIMARY KEY,
    student_id           INTEGER NOT NULL,
    subject_id           INTEGER NOT NULL,
    timetable_id         INTEGER,
    date                 DATE NOT NULL,
    status               VARCHAR(10) NOT NULL CHECK (status IN ('Present', 'Absent', 'Late', 'Excused')),
    academic_session_id  INTEGER NOT NULL,
    semester             INTEGER NOT NULL,
    marked_by            INTEGER,
    remarks              TEXT,
    created_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_attendance_student FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fk_attendance_subject FOREIGN KEY (subject_id) REFERENCES subject(id) ON DELETE CASCADE,
    CONSTRAINT fk_attendance_timetable FOREIGN KEY (timetable_id) REFERENCES timetable(id) ON DELETE SET NULL,
    CONSTRAINT fk_attendance_academic_session FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE,
    CONSTRAINT fk_attendance_marked_by FOREIGN KEY (marked_by) REFERENCES staff(id) ON DELETE SET NULL,
    CONSTRAINT unique_student_date_subject UNIQUE (student_id, date, subject_id)
);

CREATE INDEX idx_attendance_student_id ON attendance (student_id);
CREATE INDEX idx_attendance_subject_id ON attendance (subject_id);
CREATE INDEX idx_attendance_date ON attendance (date);
CREATE INDEX idx_attendance_academic_session_id ON attendance (academic_session_id);
CREATE INDEX idx_attendance_status ON attendance (status);

COMMENT ON TABLE attendance IS 'Subject-wise daily attendance records';
COMMENT ON COLUMN attendance.student_id IS 'References student.id';
COMMENT ON COLUMN attendance.subject_id IS 'References subject.id';
COMMENT ON COLUMN attendance.timetable_id IS 'Optional reference to timetable.id';
COMMENT ON COLUMN attendance.date IS 'Date of attendance';
COMMENT ON COLUMN attendance.status IS 'Attendance status: Present, Absent, Late, Excused';
COMMENT ON COLUMN attendance.academic_session_id IS 'References academic_session.id';
COMMENT ON COLUMN attendance.semester IS 'Semester number (1-8)';
COMMENT ON COLUMN attendance.marked_by IS 'References staff.id (who marked the attendance)';
COMMENT ON COLUMN attendance.remarks IS 'Additional remarks or notes';