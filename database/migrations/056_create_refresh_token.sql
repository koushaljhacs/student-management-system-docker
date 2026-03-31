/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 056_create_refresh_token.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `refresh_token` table for JWT refresh tokens.
============================================================================
*/

CREATE TABLE IF NOT EXISTS refresh_token (
    id         SERIAL PRIMARY KEY,
    user_type  VARCHAR(10) NOT NULL CHECK (user_type IN ('student', 'staff', 'parent', 'alumni')),
    user_id    INTEGER NOT NULL,
    token      TEXT UNIQUE NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    revoked    BOOLEAN DEFAULT FALSE
);

CREATE INDEX idx_refresh_token_user ON refresh_token (user_type, user_id);
CREATE INDEX idx_refresh_token_token ON refresh_token (token);
CREATE INDEX idx_refresh_token_expires_at ON refresh_token (expires_at);
CREATE INDEX idx_refresh_token_revoked ON refresh_token (revoked);

COMMENT ON TABLE refresh_token IS 'JWT refresh tokens for authentication';
COMMENT ON COLUMN refresh_token.user_type IS 'Type of user: student, staff, parent, alumni';
COMMENT ON COLUMN refresh_token.user_id IS 'Primary key of corresponding profile table';
COMMENT ON COLUMN refresh_token.token IS 'Refresh token string (unique)';
COMMENT ON COLUMN refresh_token.expires_at IS 'Expiry timestamp for this refresh token';
COMMENT ON COLUMN refresh_token.revoked IS 'Whether this token has been revoked (e.g., on logout)';