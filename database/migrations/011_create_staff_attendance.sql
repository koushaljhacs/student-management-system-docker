/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 011_create_staff_attendance.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-22
Description  : Creates the `staff_attendance` table for daily staff punch in/out.
============================================================================
*/

CREATE TABLE IF NOT EXISTS staff_attendance (
    id          SERIAL PRIMARY KEY,
    staff_id    INTEGER NOT NULL,
    date        DATE NOT NULL,
    check_in    TIME,
    check_out   TIME,
    status      VARCHAR(20) DEFAULT 'Present' CHECK (status IN ('Present','Absent','Late','Half Day','Leave')),
    remarks     TEXT,
    recorded_by INTEGER,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_staff_attendance_staff FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
    CONSTRAINT fk_staff_attendance_recorded_by FOREIGN KEY (recorded_by) REFERENCES staff(id) ON DELETE SET NULL,
    CONSTRAINT unique_staff_attendance_date UNIQUE (staff_id, date)
);

CREATE INDEX idx_staff_attendance_staff_id ON staff_attendance (staff_id);
CREATE INDEX idx_staff_attendance_date ON staff_attendance (date);
CREATE INDEX idx_staff_attendance_status ON staff_attendance (status);

COMMENT ON TABLE staff_attendance IS 'Daily attendance records for staff (punch in/out)';
COMMENT ON COLUMN staff_attendance.staff_id IS 'References staff.id';
COMMENT ON COLUMN staff_attendance.date IS 'Attendance date';
COMMENT ON COLUMN staff_attendance.check_in IS 'Punch in time';
COMMENT ON COLUMN staff_attendance.check_out IS 'Punch out time';
COMMENT ON COLUMN staff_attendance.status IS 'Attendance status';
COMMENT ON COLUMN staff_attendance.recorded_by IS 'Staff who recorded this (system or HR)';