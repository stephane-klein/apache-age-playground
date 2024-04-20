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
        (b:Issue),
        (c:Issue)
    WHERE
        a.iid = 1 AND
        b.iid = 2 AND
        c.iid = 3
    CREATE
        (a)-[rel1:IS_BLOCKED_BY]->(b)
    CREATE
        (a)-[rel2:IS_BLOCKED_BY]->(c)
$$) as (v agtype);

\echo 'Create some Labels (vertices)';
SELECT *
FROM cypher('graph_a', $$
    CREATE (
        l1:Label
        {
            name: 'Bug'
        }
    )
    CREATE (
        l2:Label
        {
            name: 'Feature'
        }
    )
    CREATE (
        l3:Label
        {
            name: 'Spike'
        }
    )
$$) as (v agtype);

\o
\echo 'Query 1: find issue 1 and display its title';
SELECT *
FROM cypher('graph_a', $$
    MATCH (issues:Issue {iid: 3})
    RETURN issues.title
$$) as (issues agtype);

\echo 'Query 2: return all edges of issue 1';
SELECT *
FROM cypher('graph_a', $$
    MATCH (n:Issue {iid: 1})-[r]->()
    RETURN r
$$) as (edges agtype);

\echo 'Query 3: find all labels';
SELECT *
FROM cypher('graph_a', $$
    MATCH (label:Label)
    RETURN label.name
$$) as (labels agtype);
