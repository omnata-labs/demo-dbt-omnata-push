A demo of Omnata Push.

```
dbt deps
dbt seed
dbt run --full-refresh --vars 'drop-omnata-task-tables: true'
dbt test
```