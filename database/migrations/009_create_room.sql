/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 009_create_room.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-21
Description  : Creates the `room` table for physical classrooms/rooms.
============================================================================
*/

CREATE TABLE IF NOT EXISTS room (
    id          SERIAL PRIMARY KEY,
    room_number VARCHAR(20) UNIQUE NOT NULL,   -- e.g., 101, Lab-2
    capacity    INTEGER,
    building    VARCHAR(100),
    floor       INTEGER,
    is_active   BOOLEAN DEFAULT TRUE,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_room_number ON room (room_number);
CREATE INDEX idx_room_building ON room (building);
CREATE INDEX idx_room_is_active ON room (is_active);

COMMENT ON TABLE room IS 'Physical classrooms/rooms for timetable and exam scheduling';
COMMENT ON COLUMN room.room_number IS 'Room number or identifier, unique';
COMMENT ON COLUMN room.capacity IS 'Maximum seating capacity';
COMMENT ON COLUMN room.building IS 'Building name';
COMMENT ON COLUMN room.floor IS 'Floor number';
COMMENT ON COLUMN room.is_active IS 'Whether the room is currently available for scheduling';