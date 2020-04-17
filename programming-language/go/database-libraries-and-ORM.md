Overall good and well-maintained library is sqlx
<https://github.com/jmoiron/sqlx>). You write prepared statements and sqlx
handles the marshalling to and from structs.

`soda` aka `pop` seems to be a decent ActiveRecord-type library
<https://github.com/gobuffalo/pop>

`squirrel` is a popular query builder too. I see little benefit over writing raw
SQL. Also, doesn’t avoid SQL-injection, which should be the bare-minimum
<https://github.com/masterminds/squirrel>

sqlc generates Go from SQL files <https://github.com/kyleconroy/sqlc>
