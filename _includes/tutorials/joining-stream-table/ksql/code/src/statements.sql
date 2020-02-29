CREATE TABLE movies (ROWKEY INT KEY, id INT, title VARCHAR, release_year INT)
    WITH (kafka_topic='movies', key='id', partitions=1, value_format='avro');

CREATE STREAM ratings (ROWKEY INT KEY, id INT, rating DOUBLE)
    WITH (kafka_topic='ratings', key='id', partitions=1, value_format='avro');

CREATE STREAM rated_movies
    WITH (kafka_topic='rated_movies',
          partitions=1,
          value_format='avro') AS
    SELECT ratings.id AS id, title, release_year, rating
    FROM ratings
    LEFT JOIN movies ON ratings.id = movies.id;
