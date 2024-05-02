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

```sh
$ ./scripts/enter-in-pg.sh -f playground.sql
Create some vertices, some Issues;
Create some Labels (vertices);
Query 1: find issue 1 and display its title;
  issues
-----------
 "Issue 3"
(1 ligne)

Query 2: return Labels (all edges) of issue 1;
 edges
-------
 "Bug"
(1 ligne)

Query 3: find all labels;
  labels
-----------
 "Bug"
 "Feature"
 "Spike"
(3 lignes)

Query 4: retrieve all "features" issues;
  issues
-----------
 "Issue 2"
 "Issue 3"
(2 lignes)

Query 5: retrieve all "features" issue that are not "spikes";
  issues
-----------
 "Issue 2"
(1 ligne)

Query 6: retrieve all issue 1 children;
  issues
-----------
 "Issue 2"
(1 ligne)

Query 7: retrieve all issue 3 children;
  issues
-----------
 "Issue 1"
 "Issue 2"
(2 lignes)
```

## Age Viewer

```sh
$ firefox http://localhost:3000/
```

<img src="screenshots/connect-to-database.png" />

```sql
SELECT *
FROM cypher('graph_a', $$
    MATCH (i1:Issue)-[r]->(i2:Issue)
    RETURN i1, r, i2
$$) as (i1 agtype, r agtype, i2 agtype);
```

<img src="screenshots/execute-query.png" />
