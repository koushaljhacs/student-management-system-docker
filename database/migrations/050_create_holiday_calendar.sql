/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 050_create_holiday_calendar.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `holiday_calendar` table for holidays and non-working days.
============================================================================
*/

CREATE TABLE IF NOT EXISTS holiday_calendar (
    id                   SERIAL PRIMARY KEY,
    name                 VARCHAR(100) NOT NULL,
    date                 DATE NOT NULL,
    type                 VARCHAR(20) NOT NULL CHECK (type IN ('public_holiday', 'religious', 'weekend', 'institute_closure')),
    is_off               BOOLEAN DEFAULT TRUE,
    description          TEXT,
    academic_session_id  INTEGER,
    created_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_holiday_calendar_session FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE,
    CONSTRAINT unique_holiday_date_session UNIQUE (date, academic_session_id)
);

CREATE INDEX idx_holiday_calendar_date ON holiday_calendar (date);
CREATE INDEX idx_holiday_calendar_type ON holiday_calendar (type);
CREATE INDEX idx_holiday_calendar_session_id ON holiday_calendar (academic_session_id);

COMMENT ON TABLE holiday_calendar IS 'List of holidays and non-working days';
COMMENT ON COLUMN holiday_calendar.name IS 'Name of holiday (e.g., Diwali, Sunday)';
COMMENT ON COLUMN holiday_calendar.date IS 'Date of the holiday';
COMMENT ON COLUMN holiday_calendar.type IS 'Type: public_holiday, religious, weekend, institute_closure';
COMMENT ON COLUMN holiday_calendar.is_off IS 'Whether classes/offices are off on this day';
COMMENT ON COLUMN holiday_calendar.description IS 'Additional details about the holiday';
COMMENT ON COLUMN holiday_calendar.academic_session_id IS 'References academic_session.id (NULL if perennial holiday)';