/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 043_create_transport_allocation.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `transport_allocation` table for assigning students to bus routes.
============================================================================
*/

CREATE TABLE IF NOT EXISTS transport_allocation (
    id                   SERIAL PRIMARY KEY,
    student_id           INTEGER NOT NULL,
    route_id             INTEGER NOT NULL,
    academic_session_id  INTEGER NOT NULL,
    start_date           DATE NOT NULL,
    end_date             DATE,
    is_active            BOOLEAN DEFAULT TRUE,
    created_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_transport_allocation_student FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fk_transport_allocation_route FOREIGN KEY (route_id) REFERENCES transport_route(id) ON DELETE CASCADE,
    CONSTRAINT fk_transport_allocation_academic_session FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE,
    CONSTRAINT unique_student_transport_session UNIQUE (student_id, academic_session_id)
);

CREATE INDEX idx_transport_allocation_student_id ON transport_allocation (student_id);
CREATE INDEX idx_transport_allocation_route_id ON transport_allocation (route_id);
CREATE INDEX idx_transport_allocation_academic_session_id ON transport_allocation (academic_session_id);
CREATE INDEX idx_transport_allocation_is_active ON transport_allocation (is_active);

COMMENT ON TABLE transport_allocation IS 'Assigns a student to a bus route for a session';
COMMENT ON COLUMN transport_allocation.student_id IS 'References student.id';
COMMENT ON COLUMN transport_allocation.route_id IS 'References transport_route.id';
COMMENT ON COLUMN transport_allocation.academic_session_id IS 'References academic_session.id';
COMMENT ON COLUMN transport_allocation.start_date IS 'Start date of transport allocation';
COMMENT ON COLUMN transport_allocation.end_date IS 'End date (NULL if ongoing)';
COMMENT ON COLUMN transport_allocation.is_active IS 'Whether this allocation is currently active';