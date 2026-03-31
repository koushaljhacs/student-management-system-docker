/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 030_create_exam_schedule.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `exam_schedule` table for scheduling exams with date,
               time, room, invigilator, and publish flag.
============================================================================
*/

CREATE TABLE IF NOT EXISTS exam_schedule (
    id                   SERIAL PRIMARY KEY,
    exam_type_id         INTEGER NOT NULL,
    course_id            INTEGER NOT NULL,
    semester             INTEGER NOT NULL,
    section_id           INTEGER NOT NULL,
    subject_id           INTEGER NOT NULL,
    academic_session_id  INTEGER NOT NULL,
    exam_date            DATE NOT NULL,
    start_time           TIME NOT NULL,
    end_time             TIME NOT NULL,
    room_id              INTEGER,
    invigilator_id       INTEGER,
    is_published         BOOLEAN DEFAULT FALSE,
    created_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_exam_schedule_type FOREIGN KEY (exam_type_id) REFERENCES exam_type(id) ON DELETE CASCADE,
    CONSTRAINT fk_exam_schedule_course FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE,
    CONSTRAINT fk_exam_schedule_section FOREIGN KEY (section_id) REFERENCES section(id) ON DELETE CASCADE,
    CONSTRAINT fk_exam_schedule_subject FOREIGN KEY (subject_id) REFERENCES subject(id) ON DELETE CASCADE,
    CONSTRAINT fk_exam_schedule_academic_session FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE,
    CONSTRAINT fk_exam_schedule_room FOREIGN KEY (room_id) REFERENCES room(id) ON DELETE SET NULL,
    CONSTRAINT fk_exam_schedule_invigilator FOREIGN KEY (invigilator_id) REFERENCES staff(id) ON DELETE SET NULL
);

CREATE INDEX idx_exam_schedule_course_id ON exam_schedule (course_id);
CREATE INDEX idx_exam_schedule_subject_id ON exam_schedule (subject_id);
CREATE INDEX idx_exam_schedule_exam_date ON exam_schedule (exam_date);
CREATE INDEX idx_exam_schedule_is_published ON exam_schedule (is_published);
CREATE INDEX idx_exam_schedule_academic_session_id ON exam_schedule (academic_session_id);

COMMENT ON TABLE exam_schedule IS 'Scheduled exams with date, time, room, invigilator, and publish flag';
COMMENT ON COLUMN exam_schedule.exam_type_id IS 'References exam_type.id';
COMMENT ON COLUMN exam_schedule.course_id IS 'References course.id';
COMMENT ON COLUMN exam_schedule.semester IS 'Semester number (1-8)';
COMMENT ON COLUMN exam_schedule.section_id IS 'References section.id';
COMMENT ON COLUMN exam_schedule.subject_id IS 'References subject.id';
COMMENT ON COLUMN exam_schedule.academic_session_id IS 'References academic_session.id';
COMMENT ON COLUMN exam_schedule.exam_date IS 'Date of the exam';
COMMENT ON COLUMN exam_schedule.start_time IS 'Exam start time';
COMMENT ON COLUMN exam_schedule.end_time IS 'Exam end time';
COMMENT ON COLUMN exam_schedule.room_id IS 'References room.id (exam venue)';
COMMENT ON COLUMN exam_schedule.invigilator_id IS 'References staff.id (invigilator for this exam)';
COMMENT ON COLUMN exam_schedule.is_published IS 'Whether exam results are visible to students';