#database_yml

database_yml is a script to generate the database.yml for rails projects.

##Install

`gem install database_yml`

##Usage
Just run `database_yml` in your rails application directory specifiying the database


```
database_yml -d mysql
database_yml -d postgresql
database_yml -d sqlite3
```
or simply run `database_yml` to generate the database.yml for sqlite3
