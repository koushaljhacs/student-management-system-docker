/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 014_create_hostel_warden.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-22
Description  : Creates the `hostel_warden` table for hostel warden assignments.
============================================================================
*/

CREATE TABLE IF NOT EXISTS hostel_warden (
    id                   SERIAL PRIMARY KEY,
    staff_id             INTEGER NOT NULL,
    hostel_id            INTEGER NOT NULL,
    academic_session_id  INTEGER NOT NULL,
    from_date            DATE NOT NULL,
    to_date              DATE,
    is_current           BOOLEAN DEFAULT TRUE,
    created_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_hostel_warden_staff FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
    CONSTRAINT fk_hostel_warden_hostel FOREIGN KEY (hostel_id) REFERENCES hostel(id) ON DELETE CASCADE,
    CONSTRAINT fk_hostel_warden_academic_session FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE
);

CREATE INDEX idx_hostel_warden_staff_id ON hostel_warden (staff_id);
CREATE INDEX idx_hostel_warden_hostel_id ON hostel_warden (hostel_id);
CREATE INDEX idx_hostel_warden_academic_session_id ON hostel_warden (academic_session_id);
CREATE INDEX idx_hostel_warden_is_current ON hostel_warden (is_current);

COMMENT ON TABLE hostel_warden IS 'Hostel warden assignment for a given session';
COMMENT ON COLUMN hostel_warden.staff_id IS 'References staff.id (the warden)';
COMMENT ON COLUMN hostel_warden.hostel_id IS 'References hostel.id';
COMMENT ON COLUMN hostel_warden.academic_session_id IS 'References academic_session.id';
COMMENT ON COLUMN hostel_warden.from_date IS 'Start date of warden duty';
COMMENT ON COLUMN hostel_warden.to_date IS 'End date (null if ongoing)';
COMMENT ON COLUMN hostel_warden.is_current IS 'Whether this is the current assignment';