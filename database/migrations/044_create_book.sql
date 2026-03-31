/*
============================================================================
FILE INFORMATION
============================================================================
File Name    : 044_create_book.sql
Developer    : Koushal Jha
Contact      : koushaljha.cs@gmail.com
Version      : 1.0.0
Date         : 2026-03-31
Description  : Creates the `book` table for library books.
============================================================================
*/

CREATE TABLE IF NOT EXISTS book (
    id               SERIAL PRIMARY KEY,
    title            VARCHAR(255) NOT NULL,
    author           VARCHAR(100),
    isbn             VARCHAR(20) UNIQUE,
    publisher        VARCHAR(100),
    year             INTEGER,
    total_copies     INTEGER NOT NULL,
    available_copies INTEGER NOT NULL,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_book_title ON book (title);
CREATE INDEX idx_book_author ON book (author);
CREATE INDEX idx_book_isbn ON book (isbn);
CREATE INDEX idx_book_publisher ON book (publisher);

COMMENT ON TABLE book IS 'Library books catalog';
COMMENT ON COLUMN book.title IS 'Book title';
COMMENT ON COLUMN book.author IS 'Author name';
COMMENT ON COLUMN book.isbn IS 'International Standard Book Number (unique)';
COMMENT ON COLUMN book.publisher IS 'Publisher name';
COMMENT ON COLUMN book.year IS 'Publication year';
COMMENT ON COLUMN book.total_copies IS 'Total copies owned by library';
COMMENT ON COLUMN book.available_copies IS 'Copies currently available for issue';