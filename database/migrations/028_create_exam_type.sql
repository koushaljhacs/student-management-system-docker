/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 028_create_exam_type.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `exam_type` table for categorizing different types of exams.
============================================================================
*/

CREATE TABLE IF NOT EXISTS exam_type (
    id                SERIAL PRIMARY KEY,
    name              VARCHAR(50) UNIQUE NOT NULL,
    weightage_percent INTEGER,
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_exam_type_name ON exam_type (name);

COMMENT ON TABLE exam_type IS 'Types of exams (e.g., Internal, External, Final)';
COMMENT ON COLUMN exam_type.name IS 'Exam type name (e.g., Internal, External, Final)';
COMMENT ON COLUMN exam_type.weightage_percent IS 'Weightage percentage for final grade calculation';