/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 055_create_otp.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `otp` table for one-time passwords for verification.
============================================================================
*/

CREATE TABLE IF NOT EXISTS otp (
    id            SERIAL PRIMARY KEY,
    user_type     VARCHAR(10) NOT NULL CHECK (user_type IN ('student', 'staff', 'parent', 'alumni')),
    user_id       INTEGER NOT NULL,
    contact_type  VARCHAR(10) NOT NULL CHECK (contact_type IN ('email', 'phone')),
    contact_value VARCHAR(255) NOT NULL,
    otp_code      VARCHAR(10) NOT NULL,
    purpose       VARCHAR(20) NOT NULL CHECK (purpose IN ('registration', 'password_change', 'phone_update', 'email_update')),
    expires_at    TIMESTAMP NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    used          BOOLEAN DEFAULT FALSE
);

CREATE INDEX idx_otp_user ON otp (user_type, user_id);
CREATE INDEX idx_otp_contact ON otp (contact_type, contact_value);
CREATE INDEX idx_otp_expires_at ON otp (expires_at);
CREATE INDEX idx_otp_used ON otp (used);

COMMENT ON TABLE otp IS 'One-time passwords for email/phone verification';
COMMENT ON COLUMN otp.user_type IS 'Type of user: student, staff, parent, alumni';
COMMENT ON COLUMN otp.user_id IS 'Primary key of corresponding profile table';
COMMENT ON COLUMN otp.contact_type IS 'Type of contact: email or phone';
COMMENT ON COLUMN otp.contact_value IS 'Email address or phone number';
COMMENT ON COLUMN otp.otp_code IS 'One-time password code';
COMMENT ON COLUMN otp.purpose IS 'Purpose: registration, password_change, phone_update, email_update';
COMMENT ON COLUMN otp.expires_at IS 'Expiry timestamp for this OTP';
COMMENT ON COLUMN otp.used IS 'Whether this OTP has been used already';