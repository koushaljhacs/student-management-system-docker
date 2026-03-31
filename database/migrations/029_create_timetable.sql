/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 029_create_timetable.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `timetable` table for weekly class schedule.
============================================================================
*/

CREATE TABLE IF NOT EXISTS timetable (
    id                   SERIAL PRIMARY KEY,
    course_id            INTEGER NOT NULL,
    semester             INTEGER NOT NULL,
    section_id           INTEGER NOT NULL,
    academic_session_id  INTEGER NOT NULL,
    subject_id           INTEGER NOT NULL,
    day_of_week          INTEGER NOT NULL CHECK (day_of_week BETWEEN 1 AND 7),
    start_time           TIME NOT NULL,
    end_time             TIME NOT NULL,
    room_id              INTEGER,
    teacher_id           INTEGER,
    created_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_timetable_course FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE,
    CONSTRAINT fk_timetable_section FOREIGN KEY (section_id) REFERENCES section(id) ON DELETE CASCADE,
    CONSTRAINT fk_timetable_academic_session FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE,
    CONSTRAINT fk_timetable_subject FOREIGN KEY (subject_id) REFERENCES subject(id) ON DELETE CASCADE,
    CONSTRAINT fk_timetable_room FOREIGN KEY (room_id) REFERENCES room(id) ON DELETE SET NULL,
    CONSTRAINT fk_timetable_teacher FOREIGN KEY (teacher_id) REFERENCES staff(id) ON DELETE SET NULL,
    CONSTRAINT unique_timetable_slot UNIQUE (course_id, semester, section_id, academic_session_id, day_of_week, start_time, room_id)
);

CREATE INDEX idx_timetable_course_semester_section ON timetable (course_id, semester, section_id);
CREATE INDEX idx_timetable_teacher_id ON timetable (teacher_id);
CREATE INDEX idx_timetable_academic_session_id ON timetable (academic_session_id);
CREATE INDEX idx_timetable_day_of_week ON timetable (day_of_week);

COMMENT ON TABLE timetable IS 'Weekly timetable for classes';
COMMENT ON COLUMN timetable.course_id IS 'References course.id';
COMMENT ON COLUMN timetable.semester IS 'Semester number (1-8)';
COMMENT ON COLUMN timetable.section_id IS 'References section.id';
COMMENT ON COLUMN timetable.academic_session_id IS 'References academic_session.id';
COMMENT ON COLUMN timetable.subject_id IS 'References subject.id';
COMMENT ON COLUMN timetable.day_of_week IS '1=Monday, 2=Tuesday, ..., 7=Sunday';
COMMENT ON COLUMN timetable.start_time IS 'Class start time';
COMMENT ON COLUMN timetable.end_time IS 'Class end time';
COMMENT ON COLUMN timetable.room_id IS 'References room.id';
COMMENT ON COLUMN timetable.teacher_id IS 'References staff.id (faculty teaching this class)';