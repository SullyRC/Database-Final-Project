/* 
Key Views
*/
CREATE VIEW AverageMovieRating
AS
SELECT movie.title, AVG(ratings.rating) as AverageRating,
COUNT(ratings.rating) as NumberRatings
FROM movie
RIGHT JOIN ratingusermovie ON movie.movieID = ratingusermovie.movieID
INNER JOIN ratings ON ratings.ratingID = ratingusermovie.ratingID
GROUP BY movie.movieID;

CREATE VIEW AverageUserRating
AS
SELECT username.userID, AVG(ratings.rating) as AverageRating
FROM username
LEFT JOIN ratingusermovie ON username.userID = ratingusermovie.userID
INNER JOIN ratings ON ratingusermovie.ratingID = ratings.ratingID
GROUP BY username.userID;

CREATE VIEW MovieTagCount
AS
SELECT movie.title, COUNT(tags.tag) as NumberTags
FROM movie
RIGHT JOIN tagusermovie ON movie.movieID = tagusermovie.movieID
INNER JOIN tags ON tagusermovie.tagID = tags.tagID
GROUP BY movie.movieID;

CREATE VIEW AverageGenreRating
AS
SELECT genre.genre, AVG(ratings.rating) as AverageRating, COUNT(genre.genreID) as NumberRatings
FROM genre
RIGHT JOIN moviegenre ON genre.genreID = moviegenre.genreID
RIGHT JOIN ratingusermovie ON moviegenre.movieID = ratingusermovie.movieID
INNER JOIN ratings ON ratingusermovie.ratingID = ratings.ratingID
GROUP BY genre.genreID;

CREATE VIEW GenreMovieCount
AS
SELECT genre.genre, COUNT(moviegenre.movieID) as NumberMovies
FROM genre
RIGHT JOIN moviegenre ON genre.genreID = moviegenre.genreID
GROUP BY genre.genreID;

CREATE VIEW GenreTagCount
AS
SELECT genre.genre, COUNT(tagusermovie.tagID) as NumberTags
FROM genre
RIGHT JOIN moviegenre ON genre.genreID = moviegenre.genreID
RIGHT JOIN tagusermovie ON tagusermovie.movieID = moviegenre.movieID
GROUP BY genre.genreID;