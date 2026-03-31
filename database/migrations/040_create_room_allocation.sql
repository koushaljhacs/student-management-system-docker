/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 040_create_room_allocation.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `room_allocation` table for assigning students to hostel rooms.
============================================================================
*/

CREATE TABLE IF NOT EXISTS room_allocation (
    id                   SERIAL PRIMARY KEY,
    student_id           INTEGER NOT NULL,
    hostel_room_id       INTEGER NOT NULL,
    academic_session_id  INTEGER NOT NULL,
    start_date           DATE NOT NULL,
    end_date             DATE,
    is_current           BOOLEAN DEFAULT TRUE,
    created_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_room_allocation_student FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fk_room_allocation_hostel_room FOREIGN KEY (hostel_room_id) REFERENCES hostel_room(id) ON DELETE CASCADE,
    CONSTRAINT fk_room_allocation_academic_session FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE,
    CONSTRAINT unique_student_session_allocation UNIQUE (student_id, academic_session_id)
);

CREATE INDEX idx_room_allocation_student_id ON room_allocation (student_id);
CREATE INDEX idx_room_allocation_hostel_room_id ON room_allocation (hostel_room_id);
CREATE INDEX idx_room_allocation_academic_session_id ON room_allocation (academic_session_id);
CREATE INDEX idx_room_allocation_is_current ON room_allocation (is_current);

COMMENT ON TABLE room_allocation IS 'Assigns a student to a room for a given academic session';
COMMENT ON COLUMN room_allocation.student_id IS 'References student.id';
COMMENT ON COLUMN room_allocation.hostel_room_id IS 'References hostel_room.id';
COMMENT ON COLUMN room_allocation.academic_session_id IS 'References academic_session.id';
COMMENT ON COLUMN room_allocation.start_date IS 'Start date of room allocation';
COMMENT ON COLUMN room_allocation.end_date IS 'End date (NULL if ongoing)';
COMMENT ON COLUMN room_allocation.is_current IS 'Whether this is the current active allocation';