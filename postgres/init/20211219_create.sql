SET client_encoding = 'UTF8';

-- CREATE DATABASE myapp;
-- \c myapp
CREATE EXTENSION "uuid-ossp";
CREATE TYPE QUESTION_TYPE AS ENUM ('SELECT','TEXT','FILE');

----------
-- Enquete
----------
CREATE TABLE enquetes(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    -- owner TEXT NOT NULL REFERENCES enquetes(id),
    description TEXT NOT NULL DEFAULT '',
    --
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE questions(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    enquete_id UUID NOT NULL REFERENCES enquetes(id),
    name TEXT NOT NULL,
    description TEXT NOT NULL DEFAULT '',
    "type" QUESTION_TYPE NOT NULL,
    sort INTEGER NOT NULL DEFAULT 0,
    --
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE select_questions(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    question_id UUID NOT NULL REFERENCES questions(id),
    "type" QUESTION_TYPE NOT NULL DEFAULT 'TEXT', -- AS ENUM
    multi BOOLEAN NOT NULL DEFAULT FALSE,
    require BOOLEAN NOT NULL DEFAULT FALSE,
    --
    minselect INTEGER,-- 1 if multi=FALSE, minselect <= maxselect
    maxselect INTEGER, -- 1 if multi=FALSE, minselect <= maxselect
    --
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE select_options(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    question_id UUID NOT NULL REFERENCES questions(id),
    sort INTEGER NOT NULL DEFAULT 0,
    label TEXT NOT NULL, -- selection label
    disabled_next BOOLEAN NOT NULL DEFAULT FALSE,
    --
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE text_questions(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    question_id UUID NOT NULL REFERENCES questions(id),
    "type" QUESTION_TYPE NOT NULL DEFAULT 'TEXT', -- AS ENUM
    multi BOOLEAN NOT NULL DEFAULT FALSE,
    require BOOLEAN NOT NULL DEFAULT FALSE,
    --
    pattern TEXT, -- Regexp
    message TEXT, -- Err message
    minlength INTEGER,
    maxlength INTEGER,
    --
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE file_questions(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    question_id UUID NOT NULL REFERENCES questions(id),
    "type" QUESTION_TYPE NOT NULL DEFAULT 'FILE', -- AS ENUM
    multi BOOLEAN NOT NULL DEFAULT FALSE,
    require BOOLEAN NOT NULL DEFAULT FALSE,
    --
    mimetypes TEXT, -- can separate blank, comma, semi-colon
    message TEXT, -- Err message
    minsize INTEGER,
    maxsize INTEGER,
    --
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

---------
-- Answer
---------
CREATE TABLE answers(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    enquete_id UUID NOT NULL REFERENCES enquetes(id),
    --
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE answer_details(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    enquete_id UUID NOT NULL REFERENCES enquetes(id),
    question_id UUID NOT NULL REFERENCES questions(id),
    answer_id UUID NOT NULL REFERENCES answers(id),
    "type" QUESTION_TYPE NOT NULL, -- AS ENUM
    question_sort INTEGER NOT NULL DEFAULT 0,
    option_id UUID REFERENCES select_options(id), -- only select option
    option_sort INTEGER DEFAULT 0, -- only select option
    option_label TEXT DEFAULT '', -- only select option
    answer_timestamp TIMESTAMP WITH TIME ZONE NOT NULL, -- copy from answers.created_at
    --
    value text DEFAULT NULL, -- Answer value to string
    --
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

