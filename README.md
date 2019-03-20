# kcapp-database
Database schema is managed using [Goose database migration tool](https://github.com/pressly/goose)

## Configuration

### Docker
Database can be setup using [Docker](https://www.docker.com/). 

Configure the database `environment` in  `docker-compose.yml`. (If you hate defaults...)
```
environment:
  - MYSQL_DATABASE: <schema_name>
  - MYSQL_USER: <username>
  - MYSQL_PASSWORD: <password>
  - MYSQL_ROOT_PASSWORD: <root_password>
```
Then execute, to start docker image in detached mode
```
docker-compose up -d
```

## Migrations
Migrations are handled with [Golang](https://golang.org/) + [Goose](https://github.com/pressly/goose) library

### Installation
To install `goose`
```
go get -u github.com/pressly/goose/cmd/goose
```

For a full list of migration commands see [Goose usage](https://github.com/pressly/goose#usage)

### Migration Status
`goose mysql "kcapp:abcd1234@tcp(localhost:3366)/kcapp?parseTime=true" status`

### Apply New Migrations
`goose mysql "kcapp:abcd1234@tcp(localhost:3366)/kcapp?parseTime=true" up`

### Creating new Migrations
To create a new migration run

`goose create create_table_my_new_table sql`
