-- from https://stackoverflow.com/questions/2593803/how-to-generate-the-create-table-sql-statement-for-an-existing-table-in-postgr

SELECT 'CREATE TABLE ' || relname || E'\n(\n' || array_to_string(array_agg('    ' || COLUMN_NAME || ' ' || TYPE || ' '|| not_null), E',\n') || E'\n);\n'
FROM
  (SELECT c.relname,
          a.attname AS COLUMN_NAME,
          pg_catalog.format_type(a.atttypid, a.atttypmod) AS TYPE,
          CASE
              WHEN a.attnotnull THEN 'NOT NULL'
              ELSE 'NULL'
          END AS not_null
   FROM pg_class c,
        pg_attribute a,
        pg_type t
   WHERE c.relname = '{table}'
     AND a.attnum > 0
     AND a.attrelid = c.oid
     AND a.atttypid = t.oid
   ORDER BY a.attnum) AS tabledefinition
GROUP BY relname;
