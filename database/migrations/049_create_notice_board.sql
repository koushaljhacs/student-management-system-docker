/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 049_create_notice_board.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `notice_board` table for circulars and announcements.
============================================================================
*/

CREATE TABLE IF NOT EXISTS notice_board (
    id          SERIAL PRIMARY KEY,
    title       VARCHAR(200) NOT NULL,
    content     TEXT,
    file_url    TEXT,
    target_type VARCHAR(20) NOT NULL CHECK (target_type IN ('all', 'course', 'semester', 'section', 'student', 'staff', 'department')),
    target_id   INTEGER,
    created_by  INTEGER,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at  TIMESTAMP,
    is_active   BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_notice_board_created_by FOREIGN KEY (created_by) REFERENCES staff(id) ON DELETE SET NULL
);

CREATE INDEX idx_notice_board_target ON notice_board (target_type, target_id);
CREATE INDEX idx_notice_board_created_at ON notice_board (created_at);
CREATE INDEX idx_notice_board_expires_at ON notice_board (expires_at);
CREATE INDEX idx_notice_board_is_active ON notice_board (is_active);

COMMENT ON TABLE notice_board IS 'Circulars and announcements for various target audiences';
COMMENT ON COLUMN notice_board.title IS 'Notice title';
COMMENT ON COLUMN notice_board.content IS 'Notice content/text';
COMMENT ON COLUMN notice_board.file_url IS 'Attached PDF/image URL';
COMMENT ON COLUMN notice_board.target_type IS 'Target audience type: all, course, semester, section, student, staff, department';
COMMENT ON COLUMN notice_board.target_id IS 'Reference ID based on target_type (course.id, section.id, etc.)';
COMMENT ON COLUMN notice_board.created_by IS 'References staff.id (who created the notice)';
COMMENT ON COLUMN notice_board.expires_at IS 'Optional expiry date after which notice is hidden';
COMMENT ON COLUMN notice_board.is_active IS 'Whether the notice is currently active';