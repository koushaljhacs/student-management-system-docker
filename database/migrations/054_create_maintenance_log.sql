/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 054_create_maintenance_log.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `maintenance_log` table for system maintenance events.
============================================================================
*/

CREATE TABLE IF NOT EXISTS maintenance_log (
    id               SERIAL PRIMARY KEY,
    maintenance_type VARCHAR(50) NOT NULL,
    description      TEXT,
    started_at       TIMESTAMP NOT NULL,
    ended_at         TIMESTAMP,
    performed_by     INTEGER,
    status           VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'InProgress', 'Completed', 'Failed')),
    result           TEXT,
    CONSTRAINT fk_maintenance_log_performed_by FOREIGN KEY (performed_by) REFERENCES users(id) ON DELETE SET NULL
);

CREATE INDEX idx_maintenance_log_type ON maintenance_log (maintenance_type);
CREATE INDEX idx_maintenance_log_started_at ON maintenance_log (started_at);
CREATE INDEX idx_maintenance_log_status ON maintenance_log (status);

COMMENT ON TABLE maintenance_log IS 'Logs system maintenance events (e.g., upgrades, backups, restarts)';
COMMENT ON COLUMN maintenance_log.maintenance_type IS 'Type: upgrade, backup, restart, etc.';
COMMENT ON COLUMN maintenance_log.description IS 'Detailed description of maintenance activity';
COMMENT ON COLUMN maintenance_log.started_at IS 'Start timestamp of maintenance';
COMMENT ON COLUMN maintenance_log.ended_at IS 'End timestamp (NULL if ongoing)';
COMMENT ON COLUMN maintenance_log.performed_by IS 'References users.id (who performed the maintenance)';
COMMENT ON COLUMN maintenance_log.status IS 'Current status: Pending, InProgress, Completed, Failed';
COMMENT ON COLUMN maintenance_log.result IS 'Result details or error messages';