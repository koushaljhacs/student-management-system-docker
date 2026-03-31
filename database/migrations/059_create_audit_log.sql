/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 059_create_audit_log.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `audit_log` table for tracking all critical changes.
============================================================================
*/

CREATE TABLE IF NOT EXISTS audit_log (
    id                    SERIAL PRIMARY KEY,
    table_name            VARCHAR(50) NOT NULL,
    record_id             INTEGER NOT NULL,
    action                VARCHAR(10) NOT NULL CHECK (action IN ('INSERT', 'UPDATE', 'DELETE')),
    old_data              JSONB,
    new_data              JSONB,
    changed_by_user_type  VARCHAR(10) CHECK (changed_by_user_type IN ('student', 'staff', 'parent', 'alumni')),
    changed_by_user_id    INTEGER,
    changed_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address            INET,
    user_agent            TEXT
);

CREATE INDEX idx_audit_log_table_record ON audit_log (table_name, record_id);
CREATE INDEX idx_audit_log_changed_by ON audit_log (changed_by_user_type, changed_by_user_id);
CREATE INDEX idx_audit_log_changed_at ON audit_log (changed_at);
CREATE INDEX idx_audit_log_action ON audit_log (action);

COMMENT ON TABLE audit_log IS 'Audit trail for all critical changes in the system';
COMMENT ON COLUMN audit_log.table_name IS 'Name of the table where change occurred';
COMMENT ON COLUMN audit_log.record_id IS 'Primary key of the changed record';
COMMENT ON COLUMN audit_log.action IS 'Action performed: INSERT, UPDATE, DELETE';
COMMENT ON COLUMN audit_log.old_data IS 'JSON snapshot of data before change';
COMMENT ON COLUMN audit_log.new_data IS 'JSON snapshot of data after change';
COMMENT ON COLUMN audit_log.changed_by_user_type IS 'Type of user who made the change';
COMMENT ON COLUMN audit_log.changed_by_user_id IS 'ID of user who made the change';
COMMENT ON COLUMN audit_log.changed_at IS 'Timestamp when change occurred';
COMMENT ON COLUMN audit_log.ip_address IS 'IP address of the request';
COMMENT ON COLUMN audit_log.user_agent IS 'User agent string of the client';