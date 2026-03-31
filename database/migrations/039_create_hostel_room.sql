/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 039_create_hostel_room.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `hostel_room` table for rooms within a hostel.
============================================================================
*/

CREATE TABLE IF NOT EXISTS hostel_room (
    id                SERIAL PRIMARY KEY,
    hostel_id         INTEGER NOT NULL,
    room_number       VARCHAR(20) NOT NULL,
    capacity          INTEGER NOT NULL,
    current_occupancy INTEGER DEFAULT 0,
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_hostel_room_hostel FOREIGN KEY (hostel_id) REFERENCES hostel(id) ON DELETE CASCADE,
    CONSTRAINT unique_hostel_room_number UNIQUE (hostel_id, room_number)
);

CREATE INDEX idx_hostel_room_hostel_id ON hostel_room (hostel_id);
CREATE INDEX idx_hostel_room_room_number ON hostel_room (room_number);
CREATE INDEX idx_hostel_room_capacity ON hostel_room (capacity);

COMMENT ON TABLE hostel_room IS 'Rooms within a hostel';
COMMENT ON COLUMN hostel_room.hostel_id IS 'References hostel.id';
COMMENT ON COLUMN hostel_room.room_number IS 'Room number/identifier (unique within hostel)';
COMMENT ON COLUMN hostel_room.capacity IS 'Maximum number of students allowed';
COMMENT ON COLUMN hostel_room.current_occupancy IS 'Number of students currently allocated to this room';