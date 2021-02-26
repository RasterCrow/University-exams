<?php
#In questo file sono presenti le funzioni in comune, principalmente quelle sul db.

# Returns the correct actor, based on the user input
function getCorrectActor($name, $surname) {
    $dsn = 'mysql:dbname=imdb;host=localhost;port=3306';
    $db = new PDO($dsn, '', '');
    $name = $db->quote($name . '%');
    $surname = $db->quote($surname);
    return $db->query("SELECT actors.id as id
                       FROM actors
                       WHERE first_name LIKE $name AND last_name=$surname
                       ORDER BY film_count DESC, id
                       LIMIT 1;");
  }

  # Returns all movis made by the actor in input
function getAllMovies($id) {
    $dsn = 'mysql:dbname=imdb;host=localhost;port=3306';
    $db = new PDO($dsn, '', '');
    return $db->query("SELECT movies.name as title, movies.year as year
                       FROM actors
                       JOIN roles ON actors.id = roles.actor_id
                       JOIN movies ON roles.movie_id = movies.id
                       WHERE actor_id= $id
                       ORDER BY year DESC, title");
  }

# Returns all movies made by the actor in input and kevin bacon.
function getMoviesSharedWithKevin($id) {
    $dsn = 'mysql:dbname=imdb;host=localhost;port=3306';
    $db = new PDO($dsn, '', '');
    return $db->query("SELECT movies.name as title, movies.year as year
                       FROM actors
                       JOIN roles ON actors.id = roles.actor_id
                       JOIN movies ON roles.movie_id = movies.id
                       WHERE first_name LIKE 'kevin%' AND last_name='bacon' AND movies.id IN(
                            SELECT movies.id
                            FROM actors
                            JOIN roles ON actors.id = roles.actor_id
                            JOIN movies ON roles.movie_id = movies.id
                            WHERE actor_id= $id)
                        ORDER BY year DESC, title");
  }
