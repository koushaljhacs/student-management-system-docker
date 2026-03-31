/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 020_create_file.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `file` table for polymorphic file storage management.
============================================================================
*/

CREATE TABLE IF NOT EXISTS file (
    id              SERIAL PRIMARY KEY,
    entity_type     VARCHAR(20) NOT NULL,
    entity_id       INTEGER NOT NULL,
    file_type       VARCHAR(50) NOT NULL,
    file_name       VARCHAR(255) NOT NULL,
    file_path       VARCHAR(500) NOT NULL,
    mime_type       VARCHAR(100),
    file_size_bytes INTEGER,
    is_active       BOOLEAN DEFAULT TRUE,
    uploaded_by     INTEGER,
    uploaded_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description     TEXT,
    deleted_at      TIMESTAMP,
    CONSTRAINT fk_file_uploaded_by FOREIGN KEY (uploaded_by) REFERENCES users(id) ON DELETE SET NULL
);

CREATE INDEX idx_file_entity ON file (entity_type, entity_id);
CREATE INDEX idx_file_type ON file (file_type);
CREATE INDEX idx_file_is_active ON file (is_active);
CREATE INDEX idx_file_uploaded_by ON file (uploaded_by);
CREATE INDEX idx_file_deleted_at ON file (deleted_at) WHERE deleted_at IS NULL;

COMMENT ON TABLE file IS 'Centralized management of all uploaded files (polymorphic)';
COMMENT ON COLUMN file.entity_type IS 'Type of entity: student, staff, parent, general';
COMMENT ON COLUMN file.entity_id IS 'Primary key of the corresponding table';
COMMENT ON COLUMN file.file_type IS 'Type of file: aadhar, pan, resume, profile_picture, document';
COMMENT ON COLUMN file.file_name IS 'Original file name';
COMMENT ON COLUMN file.file_path IS 'Storage path or URL';
COMMENT ON COLUMN file.mime_type IS 'MIME type of the file';
COMMENT ON COLUMN file.file_size_bytes IS 'File size in bytes';
COMMENT ON COLUMN file.is_active IS 'Whether the file is currently active';
COMMENT ON COLUMN file.uploaded_by IS 'References users.id (who uploaded it)';
COMMENT ON COLUMN file.deleted_at IS 'Soft delete timestamp';