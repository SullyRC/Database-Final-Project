# -*- coding: utf-8 -*-
"""
Created on Thursday Nov 3 2022

@author: sulli
"""

import mysql.connector as MSQL
import pandas as pd
x = True
#This loop getst the information about the database and connects to it
while x:
    username = str(input('Username:'))
    password = str(input("Password:"))
    host = str(input('Host:'))
    database = str(input('Database:'))
    try:
        mydb = MSQL.connect(user=username,password=password,
                           host=host, database=database)
        x=False
    except:
        print("Input not accepted")

#read in our csv data to put into SQL
movies = pd.read_csv('movies.csv')
ratings = pd.read_csv('ratings.csv')
#Ratings needs to be fixed for the timestamp. Next line fixes it
Users = set()
ratings['timestamp'] = pd.to_datetime(ratings['timestamp'],unit='s')
tags = pd.read_csv('tags.csv')
tags['timestamp'] = pd.to_datetime(tags['timestamp'],unit='s')
#manipulating our csv dataframes intot he correct tables
movies['genres'] = movies['genres'].apply(lambda x: x.split('|'))
MovieGenres = movies.explode('genres').reset_index()
genres = MovieGenres['genres'].unique()
genres = pd.DataFrame(zip(genres),columns=['genre'])
genres['genreID'] = genres.index + 1
for i in range(len(genres)):
    replace_dict = {genres['genre'][i]:str(genres['genreID'][i])}
    MovieGenres['genres'].replace(to_replace=replace_dict,inplace=True)
MovieGenres = MovieGenres[['movieId','genres']]
movies=movies[['movieId','title']]
Users = set()
for user in ratings['userId'].unique():
    Users.add(user)
for user in tags['userId'].unique():
    Users.add(user)
Users = pd.DataFrame(zip(list(Users)),columns=['UserId'])
tags['TagId'] = tags.index + 1
TagUserMovie = tags[['TagId','movieId','userId']].drop_duplicates()
tags = tags[['TagId','tag','timestamp']]
ratings['RatingId'] = ratings.index + 1
RatingUserMovie = ratings[['RatingId','movieId','userId']].drop_duplicates()
ratings = ratings[['RatingId','rating','timestamp']]
#Now we create a cursor for all our SQL statements
mycursor = mydb.cursor()
print('-'*10)
print('Creating Tables\n')
'''This section focuses on creating the tables'''
mycursor.execute("""
                  CREATE TABLE Movie(
                      movieID INT UNSIGNED UNIQUE NOT NULL ,
                      title VARCHAR(200) NOT NULL,
                      PRIMARY KEY(movieID)
                      );
                  CREATE TABLE Genre(
                      genreID TINYINT UNSIGNED UNIQUE NOT NULL ,
                      genre VARCHAR(25) NOT NULL,
                      PRIMARY KEY(genreID)
                      );
                  CREATE TABLE MovieGenre(
                      movieID INT UNSIGNED NOT NULL ,
                      genreID TINYINT UNSIGNED NOT NULL ,
                      FOREIGN KEY(movieID) REFERENCES Movie(movieID),
                      FOREIGN KEY(genreID) REFERENCES Genre(genreID)
                      ON DELETE CASCADE
                      ON UPDATE CASCADE);
                  CREATE TABLE Username(
                      userID INT UNSIGNED UNIQUE NOT NULL,
                      PRIMARY KEY(userID)
                      );
                  CREATE TABLE Tags(
                      tagID INT UNSIGNED UNIQUE NOT NULL,
                      tag VARCHAR(100) NOT NULL,
                      taggedAt DATETIME NOT NULL,
                      PRIMARY KEY(tagID)
                      );
                  CREATE TABLE TagUserMovie(
                      tagID INT UNSIGNED NOT NULL,
                      movieID INT UNSIGNED NOT NULL,
                      userID INT UNSIGNED NOT NULL,
                      FOREIGN KEY(tagID) REFERENCES Tags(tagID),
                      FOREIGN KEY(movieID) REFERENCES Movie(movieID),
                      FOREIGN KEY(userID) REFERENCES Username(userID)
                      ON DELETE CASCADE
                      ON UPDATE CASCADE
                      );
                  CREATE TABLE Ratings(
                      ratingID INT UNSIGNED UNIQUE NOT NULL,
                      rating DECIMAL(2,1) NOT NULL,
                      ratedAt DATETIME NOT NULL,
                      PRIMARY KEY(ratingID)
                      );
                  CREATE TABLE RatingUserMovie(
                      ratingID INT UNSIGNED NOT NULL,
                      movieID INT UNSIGNED NOT NULL,
                      userID INT UNSIGNED NOT NULL,
                      FOREIGN KEY(ratingID) REFERENCES Ratings(ratingID),
                      FOREIGN KEY(movieID) REFERENCES Movie(movieID),
                      FOREIGN KEY(userID) REFERENCES Username(userID)
                      ON DELETE CASCADE
                      ON UPDATE CASCADE
                      );
                  """)
mydb = MSQL.connect(user=username,password=password,
                           host=host, database=database)
mycursor = mydb.cursor()
"""
This section focuses on populating the database
We're gonna loop through the movies, ratings, and tags dataframes and populate our database.
We'll loop through movies first
"""

print('-'*10)
print('Populating Tables\n')
query_data_list = []
for movie in movies.index:
    movieID = str(movies['movieId'][movie])
    title = "'" + str(movies['title'][movie]) + "'"
    query_data_list.append((movieID,title))
mycursor.executemany("""
                     INSERT INTO Movie (movieID,title)
                     VALUES (%s,%s);
                     """,query_data_list)
mydb.commit()
mydb.close()
print("Movies done")
mydb = MSQL.connect(user=username,password=password,
                           host=host, database=database)
mycursor = mydb.cursor()

'''Genres'''
query_data_list = []
for genre in genres.index:
    genreID = str(genres['genreID'][genre])
    genre_ = "'" + str(genres['genre'][genre]) + "'"
    query_data_list.append((genreID,genre_))
mycursor.executemany("""
                     INSERT INTO Genre (GenreID,genre)
                     VALUES (%s,%s);
                     """,query_data_list)
mydb.commit()
mydb.close()
print("Genres done")
#Now we'll do this with ratings                     
mydb = MSQL.connect(user=username,password=password,
                           host=host, database=database)
mycursor = mydb.cursor()
'''MovieGenre'''
query_data_list = []
for MovieGenre in MovieGenres.index:
    genreID = str(MovieGenres['genres'][MovieGenre])
    movieID= str(MovieGenres['movieId'][MovieGenre])
    query_data_list.append((movieID,genreID))
mycursor.executemany("""
                     INSERT INTO MovieGenre (movieID,genreID)
                     VALUES (%s,%s);
                     """,query_data_list)
mydb.commit()
mydb.close()
print("MovieGenre done")
mydb = MSQL.connect(user=username,password=password,
                           host=host, database=database)
mycursor = mydb.cursor()
'''Username'''
query_data_list = []
for user in Users.index:
    userID = str(Users['UserId'][user])
    query_data_list.append([userID])
mycursor.executemany("""
                     INSERT INTO Username(userID)
                     VALUES (%s);
                     """,query_data_list)
mydb.commit()
mydb.close()
print("Username done")
mydb = MSQL.connect(user=username,password=password,
                           host=host, database=database)
mycursor = mydb.cursor()
'''Tags'''
query_data_list = []
for tag in tags.index:
    tagID = str(tags['TagId'][tag])
    tag_ = "'" + str(tags['tag'][tag]) + "'"
    taggedAt = str(tags['timestamp'][tag])
    query_data_list.append((tagID,tag_,taggedAt))
mycursor.executemany("""
                     INSERT INTO Tags(tagID,tag,taggedAt)
                     VALUES (%s,%s,%s);
                     """,query_data_list)
mydb.commit()
mydb.close()
print("Tags done")
mydb = MSQL.connect(user=username,password=password,
                           host=host, database=database)
mycursor = mydb.cursor()
'''TagUserMovie'''
query_data_list = []
for usertag in TagUserMovie.index:
    tagID = str(TagUserMovie['TagId'][usertag])
    userID = str(TagUserMovie['userId'][usertag])
    movieID = str(TagUserMovie['movieId'][usertag])
    query_data_list.append((tagID,movieID,userID))
mycursor.executemany("""
                     INSERT INTO TagUserMovie(tagID,movieID,userID)
                     VALUES (%s,%s,%s);
                     """,query_data_list)
mydb.commit()
mydb.close()
print("TagUserMovie done")
mydb = MSQL.connect(user=username,password=password,
                           host=host, database=database)
mycursor = mydb.cursor()
'''Ratings'''
query_data_list = []
for rating in ratings.index:
    ratingID = str(ratings['RatingId'][rating])
    rating_ = str(ratings['rating'][rating])
    ratedAt = str(ratings['timestamp'][rating])
    query_data_list.append((ratingID,rating_,ratedAt))
mycursor.executemany("""
                     INSERT INTO Ratings(ratingID,rating,ratedAt)
                     VALUES (%s,%s,%s);
                     """,query_data_list)
mydb.commit()
mydb.close()
print("Ratings done")
mydb = MSQL.connect(user=username,password=password,
                           host=host, database=database)
mycursor = mydb.cursor()
'''RatingUserMovie'''
query_data_list = []
for userrating in RatingUserMovie.index:
    ratingID = str(RatingUserMovie['RatingId'][userrating])
    userID = str(RatingUserMovie['userId'][userrating])
    movieID = str(RatingUserMovie['movieId'][userrating])
    query_data_list.append((ratingID,movieID,userID))
mycursor.executemany("""
                     INSERT INTO RatingUserMovie(ratingID,movieID,userID)
                     VALUES (%s,%s,%s);
                     """,query_data_list)
mydb.commit()
mydb.close()
print("RatingUserMovie done")
