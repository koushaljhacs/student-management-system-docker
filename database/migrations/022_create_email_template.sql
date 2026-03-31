/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 022_create_email_template.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `email_template` table for reusable email/SMS templates.
============================================================================
*/

CREATE TABLE IF NOT EXISTS email_template (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(50) UNIQUE NOT NULL,
    subject     VARCHAR(200),
    body        TEXT,
    variables   JSONB,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_email_template_name ON email_template (name);

COMMENT ON TABLE email_template IS 'Reusable email/SMS templates with placeholders';
COMMENT ON COLUMN email_template.name IS 'Template identifier (e.g., welcome_student, fee_reminder)';
COMMENT ON COLUMN email_template.subject IS 'Email subject line (can contain placeholders)';
COMMENT ON COLUMN email_template.body IS 'Email/SMS body content with placeholders';
COMMENT ON COLUMN email_template.variables IS 'JSON array of expected placeholders (e.g., ["name", "amount"])';