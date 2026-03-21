/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 010_create_staff.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-21
Description  : Creates the `staff` table for all staff members (teachers, admins, managers, etc.).
============================================================================
*/

CREATE TABLE IF NOT EXISTS staff (
    id                     SERIAL PRIMARY KEY,
    employee_id            VARCHAR(20) UNIQUE,
    name                   VARCHAR(100) NOT NULL,
    age                    INTEGER,
    gender                 VARCHAR(10) CHECK (gender IN ('Male','Female','Other')),
    blood_group            VARCHAR(5) CHECK (blood_group IN ('A+','A-','B+','B-','AB+','AB-','O+','O-','Unknown')),
    marital_status         VARCHAR(20) CHECK (marital_status IN ('Single','Married','Divorced','Widowed')),
    date_of_birth          DATE,
    aadhar_number          VARCHAR(12) UNIQUE,
    pan_number             VARCHAR(10) UNIQUE,
    pf_number              VARCHAR(50),
    uan_number             VARCHAR(50),
    address                TEXT,
    permanent_address      TEXT,
    joining_date           DATE,
    relieving_date         DATE,
    position               VARCHAR(100),
    department_id          INTEGER,
    reporting_to           INTEGER,
    salary                 NUMERIC(12,2),
    emergency_contact_name VARCHAR(100),
    emergency_contact      VARCHAR(15),
    work_phone             VARCHAR(15),
    qualifications         JSONB,
    bank_details           JSONB,
    employment_status      VARCHAR(20) DEFAULT 'Permanent' CHECK (employment_status IN ('Permanent','Probation','Contract','Intern')),
    contract_end_date      DATE,
    is_teaching            BOOLEAN DEFAULT FALSE,
    can_approve_leave      BOOLEAN DEFAULT FALSE,
    hostel_id              INTEGER,
    avatar_url             TEXT,
    created_at             TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at             TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at             TIMESTAMP,
    CONSTRAINT fk_staff_department FOREIGN KEY (department_id) REFERENCES department(id) ON DELETE SET NULL,
    CONSTRAINT fk_staff_reporting_to FOREIGN KEY (reporting_to) REFERENCES staff(id) ON DELETE SET NULL
    -- FK to hostel will be added after hostel table creation (see migration 038)
);

CREATE INDEX idx_staff_employee_id ON staff (employee_id);
CREATE INDEX idx_staff_department_id ON staff (department_id);
CREATE INDEX idx_staff_deleted_at ON staff (deleted_at) WHERE deleted_at IS NULL;

COMMENT ON TABLE staff IS 'All staff members (teachers, admins, managers). Authentication handled by users table.';
COMMENT ON COLUMN staff.employee_id IS 'Unique employee identifier';
COMMENT ON COLUMN staff.name IS 'Full name of staff member';
COMMENT ON COLUMN staff.department_id IS 'References department.id';
COMMENT ON COLUMN staff.reporting_to IS 'Self-reference: manager/supervisor of this staff member';
COMMENT ON COLUMN staff.salary IS 'Monthly salary';
COMMENT ON COLUMN staff.qualifications IS 'JSON array of qualifications: [{degree, institution, year}]';
COMMENT ON COLUMN staff.bank_details IS 'JSON object: {account_no, ifsc, bank_name}';
COMMENT ON COLUMN staff.employment_status IS 'Current employment status';
COMMENT ON COLUMN staff.is_teaching IS 'True if this staff member is a teaching faculty';
COMMENT ON COLUMN staff.can_approve_leave IS 'Whether this staff can approve leave applications';
COMMENT ON COLUMN staff.hostel_id IS 'If staff is a warden, references hostel.id (FK added later)';
COMMENT ON COLUMN staff.deleted_at IS 'Soft delete timestamp';