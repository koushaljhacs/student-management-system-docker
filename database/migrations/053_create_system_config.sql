/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 053_create_system_config.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `system_config` table for configuration settings.
============================================================================
*/

CREATE TABLE IF NOT EXISTS system_config (
    id          SERIAL PRIMARY KEY,
    key         VARCHAR(100) UNIQUE NOT NULL,
    value       TEXT,
    description TEXT,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_system_config_key ON system_config (key);

COMMENT ON TABLE system_config IS 'Stores configuration settings that may need runtime changes';
COMMENT ON COLUMN system_config.key IS 'Configuration key (unique)';
COMMENT ON COLUMN system_config.value IS 'Configuration value';
COMMENT ON COLUMN system_config.description IS 'Description of what this configuration does';