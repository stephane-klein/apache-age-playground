\o /dev/null
SET client_min_messages TO error;
CREATE EXTENSION IF NOT EXISTS age;
LOAD 'age';
SET search_path = ag_catalog, "$user", public;

SELECT drop_graph('graph_a', true);
SELECT create_graph('graph_a');

-- See documentation https://age.apache.org/age-manual/master/clauses/create.html#create-a-vertex-with-labels-and-properties
\echo 'Create some vertices, some Issues';
SELECT *
FROM cypher('graph_a', $$
    CREATE (
        :Issue
        {
            iid: 1,
            title: 'Issue 1'
        }
    )
$$) as (v agtype);

SELECT *
FROM cypher('graph_a', $$
    CREATE (
        :Issue
        {
            iid: 2,
            title: 'Issue 2'
        }
    )
$$) as (v agtype);

SELECT *
FROM cypher('graph_a', $$
    CREATE (
        :Issue
        {
            iid: 3,
            title: 'Issue 3'
        }
    )
$$) as (v agtype);

SELECT *
FROM cypher('graph_a', $$
    MATCH
        (a:Issue),
        (b:Issue)
    WHERE
        a.iid = 1 AND
        b.iid = 2
    CREATE (a)-[rel1:IS_BLOCKED_BY]->(b)
    RETURN rel1
$$) as (v agtype);

\o
SELECT *
FROM cypher('graph_a', $$
    MATCH (issues:Issue)
    RETURN issues
$$) as (issues agtype);


