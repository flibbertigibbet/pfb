#!/usr/bin/env bash

cd `dirname $0`

NB_POSTGRESQL_HOST="${NB_POSTGRESQL_HOST:-127.0.0.1}"
NB_POSTGRESQL_DB="${NB_POSTGRESQL_DB:-pfb}"
NB_POSTGRESQL_USER="${NB_POSTGRESQL_USER:-gis}"
NB_POSTGRESQL_PASSWORD="${NB_POSTGRESQL_PASSWORD:-gis}"

psql -h "${DBHOST}" -U "${NB_POSTGRESQL_USER}" -d "${NB_POSTGRESQL_DB}" \
  -c "SELECT tdgMakeNetwork('neighborhood_ways');"

psql -h "${NB_POSTGRESQL_HOST}" -U "${NB_POSTGRESQL_USER}" -d "${NB_POSTGRESQL_DB}" \
  -c "SELECT tdgNetworkCostFromDistance('neighborhood_ways');"

/usr/bin/time -v psql -h "${NB_POSTGRESQL_HOST}" -U "${NB_POSTGRESQL_USER}" -d "${NB_POSTGRESQL_DB}" \
  -f connectivity/census_blocks.sql

/usr/bin/time -v psql -h "${NB_POSTGRESQL_HOST}" -U "${NB_POSTGRESQL_USER}" -d "${NB_POSTGRESQL_DB}" \
  -f connectivity/census_block_roads.sql

/usr/bin/time -v psql -h "${NB_POSTGRESQL_HOST}" -U "${NB_POSTGRESQL_USER}" -d "${NB_POSTGRESQL_DB}" \
  -f connectivity/reachable_roads_high_stress.sql

/usr/bin/time -v psql -h "${NB_POSTGRESQL_HOST}" -U "${NB_POSTGRESQL_USER}" -d "${NB_POSTGRESQL_DB}" \
  -f connectivity/reachable_roads_low_stress.sql

/usr/bin/time -v psql -h "${NB_POSTGRESQL_HOST}" -U "${NB_POSTGRESQL_USER}" -d "${NB_POSTGRESQL_DB}" \
  -f connectivity/connected_census_blocks.sql

/usr/bin/time -v psql -h "${NB_POSTGRESQL_HOST}" -U "${NB_POSTGRESQL_USER}" -d "${NB_POSTGRESQL_DB}" \
  -f connectivity/access_population.sql

/usr/bin/time -v psql -h "${NB_POSTGRESQL_HOST}" -U "${NB_POSTGRESQL_USER}" -d "${NB_POSTGRESQL_DB}" \
  -f connectivity/census_block_jobs.sql

/usr/bin/time -v psql -h "${NB_POSTGRESQL_HOST}" -U "${NB_POSTGRESQL_USER}" -d "${NB_POSTGRESQL_DB}" \
  -f connectivity/access_jobs.sql

/usr/bin/time -v psql -h "${NB_POSTGRESQL_HOST}" -U "${NB_POSTGRESQL_USER}" -d "${NB_POSTGRESQL_DB}" \
  -f connectivity/schools.sql

/usr/bin/time -v psql -h "${NB_POSTGRESQL_HOST}" -U "${NB_POSTGRESQL_USER}" -d "${NB_POSTGRESQL_DB}" \
  -f connectivity/school_roads.sql

/usr/bin/time -v psql -h "${NB_POSTGRESQL_HOST}" -U "${NB_POSTGRESQL_USER}" -d "${NB_POSTGRESQL_DB}" \
  -f connectivity/connected_census_blocks_schools.sql

/usr/bin/time -v psql -h "${NB_POSTGRESQL_HOST}" -U "${NB_POSTGRESQL_USER}" -d "${NB_POSTGRESQL_DB}" \
  -f connectivity/access_schools.sql

/usr/bin/time -v psql -h "${NB_POSTGRESQL_HOST}" -U "${NB_POSTGRESQL_USER}" -d "${NB_POSTGRESQL_DB}" \
  -f connectivity/overall_scores.sql