/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 003_create_role_permission.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-21
Description  : Creates the `role_permission` junction table.
============================================================================
*/

CREATE TABLE IF NOT EXISTS role_permission (
    id            SERIAL PRIMARY KEY,
    role_id       INTEGER NOT NULL REFERENCES role(id) ON DELETE CASCADE,
    permission_id INTEGER NOT NULL REFERENCES permission(id) ON DELETE CASCADE,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(role_id, permission_id)
);

CREATE INDEX idx_role_permission_role_id ON role_permission (role_id);
CREATE INDEX idx_role_permission_permission_id ON role_permission (permission_id);

COMMENT ON TABLE role_permission IS 'Many-to-many link between roles and permissions';
COMMENT ON COLUMN role_permission.role_id IS 'Reference to role.id';
COMMENT ON COLUMN role_permission.permission_id IS 'Reference to permission.id';