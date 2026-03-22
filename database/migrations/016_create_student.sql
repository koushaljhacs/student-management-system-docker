/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 016_create_student.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-23
Description  : Creates the `student` table for all student records.
               Authentication handled by users table (no email/active here).
============================================================================
*/

CREATE TABLE IF NOT EXISTS student (
    id                      SERIAL PRIMARY KEY,
    student_id              VARCHAR(20) UNIQUE NOT NULL,
    file_number             VARCHAR(20) UNIQUE,
    name                    VARCHAR(100) NOT NULL,
    date_of_birth           DATE,
    age                     INTEGER,
    gender                  VARCHAR(10) CHECK (gender IN ('Male','Female','Other')),
    blood_group             VARCHAR(5) CHECK (blood_group IN ('A+','A-','B+','B-','AB+','AB-','O+','O-','Unknown')),
    nationality             VARCHAR(50) DEFAULT 'Indian',
    religion                VARCHAR(50),
    caste                   VARCHAR(50),
    aadhar_number           VARCHAR(12) UNIQUE,
    pan_number              VARCHAR(10) UNIQUE,
    abc_id                  VARCHAR(50),
    admission_category      VARCHAR(50),
    is_pwd                  BOOLEAN DEFAULT FALSE,
    collegename             VARCHAR(200),
    course_id               INTEGER,
    roll_number             VARCHAR(20) UNIQUE,
    library_card_number     VARCHAR(20) UNIQUE,
    admission_date          DATE,
    admission_type          VARCHAR(50),
    batch_year              INTEGER,
    graduation_date         DATE,
    medical_info            JSONB,
    previous_education      JSONB,
    alternate_email         VARCHAR(100) UNIQUE,
    phone                   VARCHAR(15) UNIQUE NOT NULL,
    alternate_phone         VARCHAR(15) UNIQUE,
    address                 TEXT,
    permanent_address       TEXT,
    avatar_url              TEXT,
    linkedin_url            VARCHAR(255),
    github_url              VARCHAR(255),
    leetcode_url            VARCHAR(255),
    portfolio_url           VARCHAR(255),
    placed_status           VARCHAR(20) DEFAULT 'Not Placed' CHECK (placed_status IN ('Not Placed','Placed','Internship')),
    placement_details       JSONB,
    class_10_percentage     NUMERIC(5,2),
    class_10_board          VARCHAR(100),
    class_10_year           INTEGER,
    class_12_percentage     NUMERIC(5,2),
    class_12_board          VARCHAR(100),
    class_12_year           INTEGER,
    graduation_percentage   NUMERIC(5,2),
    hostel_required         BOOLEAN DEFAULT FALSE,
    transport_required      BOOLEAN DEFAULT FALSE,
    scholarship_details     JSONB,
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    login_at                TIMESTAMP,
    logout_time             TIMESTAMP,
    deleted_at              TIMESTAMP,
    CONSTRAINT fk_student_course FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE SET NULL
);

CREATE INDEX idx_student_student_id ON student (student_id);
CREATE INDEX idx_student_phone ON student (phone);
CREATE INDEX idx_student_roll_number ON student (roll_number);
CREATE INDEX idx_student_course_id ON student (course_id);
CREATE INDEX idx_student_abc_id ON student (abc_id);
CREATE INDEX idx_student_admission_category ON student (admission_category);
CREATE INDEX idx_student_graduation_date ON student (graduation_date);
CREATE INDEX idx_student_placed_status ON student (placed_status);
CREATE INDEX idx_student_deleted_at ON student (deleted_at) WHERE deleted_at IS NULL;

COMMENT ON TABLE student IS 'All student records. Authentication handled by users table.';
COMMENT ON COLUMN student.student_id IS 'Internal unique ID (e.g., 2025CS001)';
COMMENT ON COLUMN student.file_number IS 'Optional file number for physical records';
COMMENT ON COLUMN student.name IS 'Full name of student';
COMMENT ON COLUMN student.course_id IS 'References course.id';
COMMENT ON COLUMN student.roll_number IS 'Roll number (unique)';
COMMENT ON COLUMN student.abc_id IS 'Academic Bank of Credits ID';
COMMENT ON COLUMN student.admission_category IS 'e.g., General, OBC, SC/ST, Management';
COMMENT ON COLUMN student.is_pwd IS 'Person with Disability';
COMMENT ON COLUMN student.medical_info IS 'JSON with allergies, chronic conditions';
COMMENT ON COLUMN student.previous_education IS 'JSON array of previous education details';
COMMENT ON COLUMN student.placement_details IS 'JSON with company, package, offer_date';
COMMENT ON COLUMN student.hostel_required IS 'Whether student needs hostel accommodation';
COMMENT ON COLUMN student.transport_required IS 'Whether student needs transport facility';
COMMENT ON COLUMN student.scholarship_details IS 'JSON with scholarship type, amount, provider, validity';
COMMENT ON COLUMN student.deleted_at IS 'Soft delete timestamp';