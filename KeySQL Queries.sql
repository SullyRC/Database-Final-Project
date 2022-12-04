/* 
Key SQL Queries
*/
SELECT movie.title, AVG(ratings.rating) as AverageRating, 
COUNT(ratings.rating) as ReviewedBy
FROM movie
LEFT JOIN ratings ON movie.movieID = ratings.movieID
GROUP BY movie.title;

SELECT userID, AVG(rating)
FROM ratings
GROUP BY userID;

SELECT movie.title, COUNT(tags.tag)
FROM movie
LEFT JOIN tags ON movie.movieID = tags.movieID
GROUP BY movie.title;