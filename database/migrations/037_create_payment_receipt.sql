/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 037_create_payment_receipt.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `payment_receipt` table for individual payment records.
============================================================================
*/

CREATE TABLE IF NOT EXISTS payment_receipt (
    id                  SERIAL PRIMARY KEY,
    student_id          INTEGER NOT NULL,
    student_invoice_id  INTEGER NOT NULL,
    amount_paid         NUMERIC(12,2) NOT NULL,
    payment_date        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method      VARCHAR(50) NOT NULL CHECK (payment_method IN ('Cash', 'Cheque', 'Online', 'Bank Transfer', 'Card')),
    reference_no        VARCHAR(100),
    refund_amount       NUMERIC(12,2) DEFAULT 0,
    refund_date         TIMESTAMP,
    remarks             TEXT,
    recorded_by         INTEGER,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_payment_student FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fk_payment_invoice FOREIGN KEY (student_invoice_id) REFERENCES student_invoice(id) ON DELETE CASCADE,
    CONSTRAINT fk_payment_recorded_by FOREIGN KEY (recorded_by) REFERENCES staff(id) ON DELETE SET NULL
);

CREATE INDEX idx_payment_student_id ON payment_receipt (student_id);
CREATE INDEX idx_payment_invoice_id ON payment_receipt (student_invoice_id);
CREATE INDEX idx_payment_date ON payment_receipt (payment_date);
CREATE INDEX idx_payment_method ON payment_receipt (payment_method);

COMMENT ON TABLE payment_receipt IS 'Individual payment records against an invoice';
COMMENT ON COLUMN payment_receipt.student_id IS 'References student.id';
COMMENT ON COLUMN payment_receipt.student_invoice_id IS 'References student_invoice.id';
COMMENT ON COLUMN payment_receipt.amount_paid IS 'Amount paid in this transaction';
COMMENT ON COLUMN payment_receipt.payment_date IS 'Date of payment';
COMMENT ON COLUMN payment_receipt.payment_method IS 'Method of payment';
COMMENT ON COLUMN payment_receipt.reference_no IS 'Cheque/Transaction reference number';
COMMENT ON COLUMN payment_receipt.refund_amount IS 'Amount refunded (if any)';
COMMENT ON COLUMN payment_receipt.refund_date IS 'Date of refund';
COMMENT ON COLUMN payment_receipt.recorded_by IS 'References staff.id (who recorded the payment)';