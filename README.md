# kcapp-database
Database schema is managed using [Liquibase](https://www.liquibase.org/)
## WIP: Breaking changes may occur!

## Configuration
### Standalone
Configuration is done through the `liquibase.properties` file. The following must be specified
```
changeLogFile: changelog.xml

driver: com.mysql.jdbc.Driver
classpath: mysql.jar

url: jdbc:mysql://<db_host>/<db_schema>
username: <db_username>
password: <db_password>
````

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

## Installing
Make sure your current directory contains both `liquibase.jar` and a [MySQL JDBC Driver](https://dev.mysql.com/downloads/connector/j/)

For a full list of Liquibase commands see [Liquibase Command Line](https://www.liquibase.org/documentation/command_line.html)

* See status of applied updates
	`java -jar liquibase.jar --defaultsFile=liquibase.properties status`
* Apply latest updates
	`java -jar liquibase.jar --defaultsFile=liquibase.properties update`
* Rollback some number of updates
	`java -jar liquibase.jar --defaultsFile=liquibase.properties rollbackCount <count>`

