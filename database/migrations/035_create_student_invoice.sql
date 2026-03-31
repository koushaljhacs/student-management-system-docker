/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 035_create_student_invoice.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `student_invoice` table for aggregate invoices per student.
============================================================================
*/

CREATE TABLE IF NOT EXISTS student_invoice (
    id                      SERIAL PRIMARY KEY,
    student_id              INTEGER NOT NULL,
    academic_session_id     INTEGER NOT NULL,
    semester                INTEGER NOT NULL,
    invoice_date            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount            NUMERIC(12,2) NOT NULL,
    paid_amount             NUMERIC(12,2) DEFAULT 0,
    discount_amount         NUMERIC(12,2) DEFAULT 0,
    late_fee                NUMERIC(12,2) DEFAULT 0,
    late_fee_applied_date   DATE,
    status                  VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Partial', 'Paid', 'Overdue', 'Cancelled')),
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_invoice_student FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fk_invoice_academic_session FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE
);

CREATE INDEX idx_invoice_student_id ON student_invoice (student_id);
CREATE INDEX idx_invoice_academic_session_id ON student_invoice (academic_session_id);
CREATE INDEX idx_invoice_status ON student_invoice (status);

COMMENT ON TABLE student_invoice IS 'Aggregate invoice for a student per semester and session';
COMMENT ON COLUMN student_invoice.student_id IS 'References student.id';
COMMENT ON COLUMN student_invoice.academic_session_id IS 'References academic_session.id';
COMMENT ON COLUMN student_invoice.semester IS 'Semester number (1-8)';
COMMENT ON COLUMN student_invoice.invoice_date IS 'Date when invoice was generated';
COMMENT ON COLUMN student_invoice.total_amount IS 'Total amount including taxes';
COMMENT ON COLUMN student_invoice.paid_amount IS 'Amount already paid';
COMMENT ON COLUMN student_invoice.discount_amount IS 'Discount/concession applied';
COMMENT ON COLUMN student_invoice.late_fee IS 'Late fee charged (if any)';
COMMENT ON COLUMN student_invoice.late_fee_applied_date IS 'Date when late fee was applied';
COMMENT ON COLUMN student_invoice.status IS 'Invoice status: Pending, Partial, Paid, Overdue, Cancelled';