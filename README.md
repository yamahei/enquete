Enquete
=======

 I want to create a simple, nifty, customizable survey system.

```sh
# init (create empty entities)
#   ./postgres/data/ ... empty but required, first.
#   ./schemaspy/output/ ... empty but required, first.
#   ./src/Gemfile.lock ... empty but required, first.
mkdir -p ./postgres/data
mkdir -p ./schemaspy/output
touch ./src/Gemfile.lock
# build and start
docker-compose build; docker-compose up -d; docker-compose ps

# into the app
# http://localhost/enquete/index.html
# docker logs app
docker-compose exec app bash
irb
require "./app.rb"

# into the db
# docker logs db * not work, invalid container name
docker-compose exec db psql -U postgres myapp

# show ER diagram * not work!
browser ./schemaspy/output/index.html

# cleanup
docker system prune
```

