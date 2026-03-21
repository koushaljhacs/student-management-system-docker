CREATE TABLE IF NOT EXISTS student (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,                     -- better than age
    age INTEGER,
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')),
    collegename VARCHAR(200),
    phonenumber VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,              
    address TEXT,                            
    roll_number VARCHAR(20) UNIQUE,          
    course VARCHAR(100),                     
    semester INTEGER,                         
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    login_at TIMESTAMP,
    logout_time TIMESTAMP
);

SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'student'

SELECT datname FROM pg_database;
SELECT datname, datistemplate, datallowconn FROM pg_database;
SELECT current_database();

SELECT current_user;
SELECT user;
SELECT current_user, session_user;

SELECT table_name 
FROM information_schema.tables 
WHERE table_schema NOT IN ('information_schema', 'pg_catalog')
AND table_type = 'BASE TABLE'
ORDER BY table_name;
-- or using pg_tables
SELECT tablename FROM pg_tables WHERE schemaname = 'public';


-- Check database permissions
SELECT * FROM information_schema.role_table_grants 
WHERE grantee = current_user;

-- Check specific table permissions
SELECT * FROM information_schema.role_table_grants 
WHERE table_name = 'student' 
AND grantee = current_user;

-- Check all privileges
SELECT * FROM information_schema.usage_privileges 
WHERE grantee = current_user;


