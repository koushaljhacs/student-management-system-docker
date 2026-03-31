/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 046_create_leave_application.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `leave_application` table for leave applications from students and staff.
============================================================================
*/

CREATE TABLE IF NOT EXISTS leave_application (
    id           SERIAL PRIMARY KEY,
    user_type    VARCHAR(10) NOT NULL CHECK (user_type IN ('student', 'staff')),
    user_id      INTEGER NOT NULL,
    leave_type   VARCHAR(50) NOT NULL CHECK (leave_type IN ('Sick', 'Casual', 'Maternity', 'Earned', 'Other')),
    start_date   DATE NOT NULL,
    end_date     DATE NOT NULL,
    reason       TEXT NOT NULL,
    status       VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Approved', 'Rejected', 'Cancelled')),
    applied_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    approved_by  INTEGER,
    approved_at  TIMESTAMP,
    remarks      TEXT,
    CONSTRAINT fk_leave_application_approved_by FOREIGN KEY (approved_by) REFERENCES staff(id) ON DELETE SET NULL
);

CREATE INDEX idx_leave_application_user ON leave_application (user_type, user_id);
CREATE INDEX idx_leave_application_type ON leave_application (leave_type);
CREATE INDEX idx_leave_application_status ON leave_application (status);
CREATE INDEX idx_leave_application_dates ON leave_application (start_date, end_date);

COMMENT ON TABLE leave_application IS 'Leave applications for students and staff';
COMMENT ON COLUMN leave_application.user_type IS 'Type of user: student or staff';
COMMENT ON COLUMN leave_application.user_id IS 'Primary key of student or staff table';
COMMENT ON COLUMN leave_application.leave_type IS 'Type of leave requested';
COMMENT ON COLUMN leave_application.start_date IS 'Start date of leave';
COMMENT ON COLUMN leave_application.end_date IS 'End date of leave';
COMMENT ON COLUMN leave_application.reason IS 'Reason for leave';
COMMENT ON COLUMN leave_application.status IS 'Application status: Pending, Approved, Rejected, Cancelled';
COMMENT ON COLUMN leave_application.approved_by IS 'References staff.id who approved/rejected the leave';
COMMENT ON COLUMN leave_application.approved_at IS 'Timestamp when decision was made';