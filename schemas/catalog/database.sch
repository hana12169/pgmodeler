# Catalog queries for database
# CAUTION: Do not modify this file unless you know what you are doing.
#          Code generation can be broken if incorrect changes are made.

%if @{list} %then
  [SELECT oid, datname AS name, datlastsysoid AS last_sys_oid FROM pg_database
   WHERE datistemplate = FALSE  ]

  %if @{hide-postgres-db} %then
   [ AND datname <> 'postgres' ]
  %end

  %if @{name} %then
   [ AND datname = ] '@{name}'
  %end

%else
    %if @{attribs} %then
      [SELECT oid, datname AS name, pg_encoding_to_char(encoding) AS encoding, datdba AS owner,
	      datcollate AS lc_collate, datctype AS lc_ctype, datconnlimit AS connlimit,
	      datacl AS permission, dattablespace AS tablespace, datdba AS owner,
	      NULL AS template, ]
	      (@{comment}) [ AS comment ]
      [ FROM pg_database WHERE datistemplate = FALSE ]

      %if @{hide-postgres-db} %then
        [ AND datname <> 'postgres' ]
      %end

      %if @{last-sys-oid} %then
       [ AND oid ] @{oid-filter-op} $sp @{last-sys-oid}
      %end

      %if @{filter-oids} %then
        [ AND oid IN (] @{filter-oids} )
      %end

    %end
%end
