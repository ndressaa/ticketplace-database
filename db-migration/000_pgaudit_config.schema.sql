CREATE EXTENSION IF NOT EXISTS pgaudit;

-- https://github.com/pgaudit/pgaudit/blob/master/README.md#pgauditlog
ALTER SYSTEM SET pgaudit.log = 'all';

-- https://github.com/pgaudit/pgaudit/blob/master/README.md#pgauditlog_catalog
ALTER SYSTEM SET pgaudit.log_catalog = off;

-- https://github.com/pgaudit/pgaudit/blob/master/README.md#pgauditlog_parameter
ALTER SYSTEM SET pgaudit.log_parameter = 'on';

-- https://github.com/pgaudit/pgaudit/blob/master/README.md#pgauditlog_catalog
ALTER SYSTEM SET pgaudit.log_relation = 'on';

-- https://github.com/pgaudit/pgaudit/blob/master/README.md#pgauditlog_rows
ALTER SYSTEM SET pgaudit.log_rows = 'on';


-- This may provide information more easily while developing. 
-- Comment if you don`t need it.
ALTER SYSTEM SET pgaudit.log_level = notice;