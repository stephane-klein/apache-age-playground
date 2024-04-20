# Apache Age playground

I created this playground to experiment for the first time how to use [Apache Age](https://age.apache.org/).

See also my <https://github.com/stephane-klein/neo4j-playground>.

```sh
$ docker compose up -d --wait
$ ./scripts/enter-in-pg.sh
postgres=# \dx
                 List of installed extensions
  Name   | Version |   Schema   |         Description
---------+---------+------------+------------------------------
 age     | 1.5.0   | ag_catalog | AGE database extension
 plpgsql | 1.0     | pg_catalog | PL/pgSQL procedural language
```

