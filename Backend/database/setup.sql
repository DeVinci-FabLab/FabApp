
DROP TABLE IF EXISTS articles;
DROP TABLE IF EXISTS users;


CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    validated BOOLEAN DEFAULT FALSE,
    info JSONB DEFAULT '{}'::JSONB,
    CONSTRAINT unique_username UNIQUE (username),
    CONSTRAINT valid_email UNIQUE (email), CHECK (email ~* '^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$')
);


CREATE TABLE articles (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    content TEXT,
    published_by INT,
    published_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_articles_users FOREIGN KEY (published_by) REFERENCES users (id)
);

--create rules for users
CREATE OR REPLACE FUNCTION check_duplicates()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM users WHERE username = NEW.username) THEN
        RAISE EXCEPTION 'Duplicate username: %', NEW.username using errcode = 23505;
    END IF;

    IF EXISTS (SELECT 1 FROM users WHERE email = NEW.email) THEN
        RAISE EXCEPTION 'Duplicate email: %', NEW.email using errcode = 23505;
    END IF;
  
    IF NEW.email !~* '^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$' THEN
        RAISE EXCEPTION 'Incorrect email format: %', NEW.email using errcode = 23514;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER duplicates_trigger
BEFORE INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION check_duplicates();