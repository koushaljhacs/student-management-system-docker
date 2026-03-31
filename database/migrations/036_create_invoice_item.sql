/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 036_create_invoice_item.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `invoice_item` table for line items within an invoice.
============================================================================
*/

CREATE TABLE IF NOT EXISTS invoice_item (
    id                  SERIAL PRIMARY KEY,
    student_invoice_id  INTEGER NOT NULL,
    fee_structure_id    INTEGER NOT NULL,
    amount              NUMERIC(12,2) NOT NULL,
    tax                 NUMERIC(12,2) DEFAULT 0,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_invoice_item_invoice FOREIGN KEY (student_invoice_id) REFERENCES student_invoice(id) ON DELETE CASCADE,
    CONSTRAINT fk_invoice_item_fee_structure FOREIGN KEY (fee_structure_id) REFERENCES fee_structure(id) ON DELETE RESTRICT
);

CREATE INDEX idx_invoice_item_invoice_id ON invoice_item (student_invoice_id);
CREATE INDEX idx_invoice_item_fee_structure_id ON invoice_item (fee_structure_id);

COMMENT ON TABLE invoice_item IS 'Line items for a student invoice (breakup of fees)';
COMMENT ON COLUMN invoice_item.student_invoice_id IS 'References student_invoice.id';
COMMENT ON COLUMN invoice_item.fee_structure_id IS 'References fee_structure.id';
COMMENT ON COLUMN invoice_item.amount IS 'Amount for this fee item';
COMMENT ON COLUMN invoice_item.tax IS 'Tax amount for this line item';