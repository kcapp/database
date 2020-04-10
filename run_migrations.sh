#!/bin/bash

# Check if goose is available
command -v goose >/dev/null 2>&1 || { echo >&2 "goose not found, unable to run migrations."; exit 1; }

# Check if database connection is set
[ -z "$DB_CONNECTION" ] && echo "Database connection not specified" && exit 1

# Set migration folder, if not specified
[ -z "$MIGRATION_FOLDER" ] && MIGRATION_FOLDER=/usr/local/kcapp/database/migrations

# Check if migration folder exist
[ ! -d "${MIGRATION_FOLDER}" ] && echo "Migration folder '$MIGRATION_FOLDER' does not exist." && exit 1

# Set command if specified
COMMAND=$1
if [ -z "$1" ] ; then
    COMMAND=up
fi

# Run migrations
goose -dir $MIGRATION_FOLDER mysql "$DB_CONNECTION" $COMMAND