SET client_encoding = 'UTF-8';
-- This controls whether ordinary string literals ('...') treat backslashes literally, as specified in the SQL standard.
-- Beginning in PostgreSQL 9.1, the default is on (prior releases defaulted to off).
-- Applications can check this parameter to determine how string literals will be processed.
-- The presence of this parameter can also be taken as an indication that the escape string syntax (E'...') is supported.
-- Escape string syntax should be used if an application desires backslashes to be treated as escape characters.
-- SET standart_conforming_string = on;
-- This parameter is normally on. When set to off, it disables validation of the function body string during CREATE FUNCTION.
-- Disabling validation avoids side effects of the validation process and avoids false positives due to problems such as forward references.
-- Set this parameter to off before loading functions on behalf of other users; pg_dump does so automatically.
SET check_function_bodies = false;
-- Controls which message levels are sent to the client. Valid values are DEBUG5, DEBUG4, DEBUG3, DEBUG2, DEBUG1, LOG, NOTICE, WARNING, ERROR, FATAL, and PANIC.
-- Each level includes all the levels that follow it. The later the level, the fewer messages are sent. The default is NOTICE.
-- Note that LOG has a different rank here than in log_min_messages.
SET client_min_messages = WARNING;

-- Full parameter information  https://www.postgresql.org/docs/9.4/static/manage-ag-tablespaces.html
SET default_tablespace = '';

-- This controls whether CREATE TABLE and CREATE TABLE AS include an OID column in newly-created tables,
-- if neither WITH OIDS nor WITHOUT OIDS is specified. It also determines whether OIDs will be included in tables created by SELECT INTO.
-- The parameter is off by default; in PostgreSQL 8.0 and earlier, it was on by default.
--
-- The use of OIDs in user tables is considered deprecated, so most installations should leave this variable disabled.
-- Applications that require OIDs for a particular table should specify WITH OIDS when creating the table.
-- This variable can be enabled for compatibility with old applications that do not follow this behavior.
SET default_with_oids = false;

-- this table acts as a lock, preventing another DB client from attempting
-- to convert a database that is in the process of initialization (must
-- be the first thing we create, and we delete it as the last action of
-- this script)
CREATE TABLE db_conversion_lock (c INTEGER);
















-- remove lock that prevents concurrent db conversion; must be the last thing we do here
DROP TABLE db_conversion_lock;