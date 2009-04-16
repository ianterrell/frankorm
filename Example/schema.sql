CREATE TABLE IF NOT EXISTS users (
  pk INTEGER PRIMARY KEY,
  username TEXT NOT NULL,
  password TEXT NOT NULL,
  awesomeness_code INTEGER
);