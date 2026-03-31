/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 057_create_password_reset_token.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `password_reset_token` table for password reset tokens.
============================================================================
*/

CREATE TABLE IF NOT EXISTS password_reset_token (
    id         SERIAL PRIMARY KEY,
    user_type  VARCHAR(10) NOT NULL CHECK (user_type IN ('student', 'staff', 'parent', 'alumni')),
    user_id    INTEGER NOT NULL,
    token      TEXT UNIQUE NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    used       BOOLEAN DEFAULT FALSE
);

CREATE INDEX idx_password_reset_token_user ON password_reset_token (user_type, user_id);
CREATE INDEX idx_password_reset_token_token ON password_reset_token (token);
CREATE INDEX idx_password_reset_token_expires_at ON password_reset_token (expires_at);
CREATE INDEX idx_password_reset_token_used ON password_reset_token (used);

COMMENT ON TABLE password_reset_token IS 'One-time tokens for password reset';
COMMENT ON COLUMN password_reset_token.user_type IS 'Type of user: student, staff, parent, alumni';
COMMENT ON COLUMN password_reset_token.user_id IS 'Primary key of corresponding profile table';
COMMENT ON COLUMN password_reset_token.token IS 'Password reset token (unique)';
COMMENT ON COLUMN password_reset_token.expires_at IS 'Expiry timestamp for this token';
COMMENT ON COLUMN password_reset_token.used IS 'Whether this token has been used already';