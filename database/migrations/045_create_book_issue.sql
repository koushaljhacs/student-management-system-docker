/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 045_create_book_issue.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `book_issue` table for tracking book issues to students.
============================================================================
*/

CREATE TABLE IF NOT EXISTS book_issue (
    id           SERIAL PRIMARY KEY,
    student_id   INTEGER NOT NULL,
    book_id      INTEGER NOT NULL,
    issue_date   DATE NOT NULL,
    due_date     DATE NOT NULL,
    return_date  DATE,
    status       VARCHAR(20) DEFAULT 'Issued' CHECK (status IN ('Issued', 'Returned', 'Overdue', 'Lost')),
    library_fine NUMERIC(8,2) DEFAULT 0,
    remarks      TEXT,
    issued_by    INTEGER,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_book_issue_student FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fk_book_issue_book FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE,
    CONSTRAINT fk_book_issue_issued_by FOREIGN KEY (issued_by) REFERENCES staff(id) ON DELETE SET NULL
);

CREATE INDEX idx_book_issue_student_id ON book_issue (student_id);
CREATE INDEX idx_book_issue_book_id ON book_issue (book_id);
CREATE INDEX idx_book_issue_status ON book_issue (status);
CREATE INDEX idx_book_issue_due_date ON book_issue (due_date);

COMMENT ON TABLE book_issue IS 'Records of books issued to students';
COMMENT ON COLUMN book_issue.student_id IS 'References student.id';
COMMENT ON COLUMN book_issue.book_id IS 'References book.id';
COMMENT ON COLUMN book_issue.issue_date IS 'Date when book was issued';
COMMENT ON COLUMN book_issue.due_date IS 'Date by which book should be returned';
COMMENT ON COLUMN book_issue.return_date IS 'Actual return date (NULL if not returned)';
COMMENT ON COLUMN book_issue.status IS 'Current status: Issued, Returned, Overdue, Lost';
COMMENT ON COLUMN book_issue.library_fine IS 'Fine amount for overdue or lost book';
COMMENT ON COLUMN book_issue.issued_by IS 'References staff.id (who issued the book)';