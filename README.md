
# init (create empty entities)
#   ./postgres_data/ ... empty but required, first.
#   ./schemaspy/output/ ... empty but required, first.
#   ./src/Gemfile.lock ... empty but required, first.
mkdir -p ./postgres_data; mkdir -p ./schemaspy/output; touch ./src/Gemfile.lock
# build and start
docker-compose build; docker-compose up -d; docker-compose ps

# into the app
docker-compose exec app bash
irb
require "./app.rb"

# into the db
docker-compose exec db psql -U postgres

# show ER diagram * not work!
browser ./schemaspy/output/index.html

# cleanup
docker system prune

