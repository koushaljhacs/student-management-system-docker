/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 019_create_users.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `users` table for unified authentication.
               This is the SINGLE SOURCE OF TRUTH for email and is_active.
============================================================================
*/

CREATE TABLE IF NOT EXISTS users (
    id                    SERIAL PRIMARY KEY,
    username              VARCHAR(50) UNIQUE NOT NULL,
    email                 VARCHAR(100) UNIQUE NOT NULL,
    password              VARCHAR(255) NOT NULL,
    user_type             VARCHAR(20) NOT NULL CHECK (user_type IN ('student','staff','parent','alumni')),
    user_id               INTEGER NOT NULL,
    role_id               INTEGER NOT NULL,
    is_active             BOOLEAN DEFAULT TRUE,
    last_login            TIMESTAMP,
    failed_login_attempts INTEGER DEFAULT 0,
    last_failed_login     TIMESTAMP,
    last_password_change  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at            TIMESTAMP,
    CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE RESTRICT,
    CONSTRAINT unique_user_type_id UNIQUE (user_type, user_id)
);

CREATE INDEX idx_users_username ON users (username);
CREATE INDEX idx_users_email ON users (email);
CREATE INDEX idx_users_role_id ON users (role_id);
CREATE INDEX idx_users_user_type_id ON users (user_type, user_id);
CREATE INDEX idx_users_deleted_at ON users (deleted_at) WHERE deleted_at IS NULL;

COMMENT ON TABLE users IS 'Central authentication table for all user types';
COMMENT ON COLUMN users.username IS 'Login username (unique)';
COMMENT ON COLUMN users.email IS 'Email address - SINGLE SOURCE OF TRUTH';
COMMENT ON COLUMN users.password IS 'bcrypt hash of password';
COMMENT ON COLUMN users.user_type IS 'Type of user: student, staff, parent, alumni';
COMMENT ON COLUMN users.user_id IS 'Primary key of corresponding profile table (student.id, staff.id, etc.)';
COMMENT ON COLUMN users.role_id IS 'References role.id';
COMMENT ON COLUMN users.is_active IS 'Account active status - SINGLE SOURCE OF TRUTH';
COMMENT ON COLUMN users.failed_login_attempts IS 'Count of consecutive failed login attempts';
COMMENT ON COLUMN users.deleted_at IS 'Soft delete timestamp';