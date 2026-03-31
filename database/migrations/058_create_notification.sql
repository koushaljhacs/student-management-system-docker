/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 058_create_notification.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `notification` table for system notifications.
============================================================================
*/

CREATE TABLE IF NOT EXISTS notification (
    id         SERIAL PRIMARY KEY,
    user_type  VARCHAR(10) NOT NULL CHECK (user_type IN ('student', 'staff', 'parent', 'alumni')),
    user_id    INTEGER NOT NULL,
    title      VARCHAR(255) NOT NULL,
    message    TEXT NOT NULL,
    type       VARCHAR(50) DEFAULT 'info' CHECK (type IN ('info', 'warning', 'alert')),
    is_read    BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at    TIMESTAMP
);

CREATE INDEX idx_notification_user ON notification (user_type, user_id);
CREATE INDEX idx_notification_is_read ON notification (is_read);
CREATE INDEX idx_notification_created_at ON notification (created_at);
CREATE INDEX idx_notification_type ON notification (type);

COMMENT ON TABLE notification IS 'System notifications for students, staff, and parents';
COMMENT ON COLUMN notification.user_type IS 'Type of user: student, staff, parent, alumni';
COMMENT ON COLUMN notification.user_id IS 'Primary key of corresponding profile table';
COMMENT ON COLUMN notification.title IS 'Notification title';
COMMENT ON COLUMN notification.message IS 'Notification message content';
COMMENT ON COLUMN notification.type IS 'Notification type: info, warning, alert';
COMMENT ON COLUMN notification.is_read IS 'Whether the notification has been read';
COMMENT ON COLUMN notification.read_at IS 'Timestamp when the notification was read';