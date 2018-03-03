# kcapp-database
Database schema is managed using [Liquibase](https://www.liquibase.org/)
## WIP: Breaking changes might happen until schema is finalized

## Configuration
Configuration is done through the `liquibase.properties` file. The following must be specified
```
changeLogFile: changelog.xml

driver: com.mysql.jdbc.Driver
classpath: mysql.jar

url: jdbc:mysql://<db_host>/<db_schema>
username: <db_username>
password: <db_password>
````

Make sure your current directory contains both `liquibase.jar` and a [MySQL JDBC Driver](https://dev.mysql.com/downloads/connector/j/)

## Install
For a full list of Liquibase commands see [Liquibase Command Line](https://www.liquibase.org/documentation/command_line.html)

* See status of applied updates
	`java -jar liquibase.jar --defaultsFile=liquibase.properties status`
* Apply latest updates
	`java -jar liquibase.jar --defaultsFile=liquibase.properties update`
* Rollback some number of updates
	`java -jar liquibase.jar --defaultsFile=liquibase.properties rollbackCount <count>`

