/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 051_create_event.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `event` table for extracurricular events, workshops, competitions.
============================================================================
*/

CREATE TABLE IF NOT EXISTS event (
    id               SERIAL PRIMARY KEY,
    name             VARCHAR(200) NOT NULL,
    description      TEXT,
    event_type       VARCHAR(50),
    start_date       DATE,
    end_date         DATE,
    venue            VARCHAR(200),
    max_participants INTEGER,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_event_name ON event (name);
CREATE INDEX idx_event_type ON event (event_type);
CREATE INDEX idx_event_start_date ON event (start_date);
CREATE INDEX idx_event_end_date ON event (end_date);

COMMENT ON TABLE event IS 'Extracurricular events, workshops, competitions, etc.';
COMMENT ON COLUMN event.name IS 'Name of the event';
COMMENT ON COLUMN event.description IS 'Detailed description of the event';
COMMENT ON COLUMN event.event_type IS 'Type: Workshop, Seminar, Sports, Cultural';
COMMENT ON COLUMN event.start_date IS 'Event start date';
COMMENT ON COLUMN event.end_date IS 'Event end date';
COMMENT ON COLUMN event.venue IS 'Venue/location of the event';
COMMENT ON COLUMN event.max_participants IS 'Maximum number of participants allowed';