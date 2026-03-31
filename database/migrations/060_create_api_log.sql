/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 060_create_api_log.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `api_log` table for logging API requests (for monitoring).
============================================================================
*/

CREATE TABLE IF NOT EXISTS api_log (
    id                SERIAL PRIMARY KEY,
    user_type         VARCHAR(10) CHECK (user_type IN ('student', 'staff', 'parent', 'alumni')),
    user_id           INTEGER,
    endpoint          VARCHAR(255) NOT NULL,
    method            VARCHAR(10) NOT NULL,
    request_body      JSONB,
    response_status   INTEGER,
    response_time_ms  INTEGER,
    ip_address        INET,
    user_agent        TEXT,
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_api_log_user ON api_log (user_type, user_id);
CREATE INDEX idx_api_log_endpoint ON api_log (endpoint);
CREATE INDEX idx_api_log_created_at ON api_log (created_at);
CREATE INDEX idx_api_log_response_status ON api_log (response_status);
CREATE INDEX idx_api_log_method ON api_log (method);

COMMENT ON TABLE api_log IS 'Logs API requests for monitoring and debugging (enable carefully)';
COMMENT ON COLUMN api_log.user_type IS 'Type of user (NULL if unauthenticated)';
COMMENT ON COLUMN api_log.user_id IS 'User ID (NULL if unauthenticated)';
COMMENT ON COLUMN api_log.endpoint IS 'API endpoint called';
COMMENT ON COLUMN api_log.method IS 'HTTP method (GET, POST, PUT, PATCH, DELETE)';
COMMENT ON COLUMN api_log.request_body IS 'Request payload (sanitized, sensitive data masked)';
COMMENT ON COLUMN api_log.response_status IS 'HTTP response status code';
COMMENT ON COLUMN api_log.response_time_ms IS 'Response time in milliseconds';
COMMENT ON COLUMN api_log.ip_address IS 'Client IP address';
COMMENT ON COLUMN api_log.user_agent IS 'User agent string';