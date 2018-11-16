# kcapp-database
Database schema is managed using [Goose database migration tool](https://github.com/pressly/goose)

## Configuration

### Docker
Database can also be setup with [Docker](https://www.docker.com/). Configure the database `environment` in  `docker-compose.yml`
```
environment:
  - MYSQL_ROOT_PASSWORD=<root_password>
  - MYSQL_USER=<db_username>
  - MYSQL_PASSWORD=<db_password>
  - MYSQL_DATABASE=<db_schema>
```
Then execute
```
docker-compose up -d
```

## Migrations
### Requirements
Golang + [Goose] library
```
go get -u github.com/pressly/goose/cmd/goose
```

For a full list of migration commands see Goose README.md https://github.com/pressly/goose

* Create new migration (creating / dropping entities)
	`goose create create_table_my_new_table sql`
* Check status of migrations
	`goose mysql "root:abcd1234@/cakedarts?parseTime=true" status`
* Apply migrations
	`goose mysql "root:abcd1234@/cakedarts?parseTime=true" up`

