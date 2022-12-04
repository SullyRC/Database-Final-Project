# -*- coding: utf-8 -*-
"""
Created on Thu Nov  3 20:01:33 2022

@author: sulli
"""
import mysql.connector as MSQL
import pandas as pd

x = True
#This loop getst the information about the database and connects to it
while x:
    user = str(input('Username:'))
    password = str(input("Password:"))
    host = str(input('Host:'))
    database = str(input('Database:'))
    database = 'Movie'
    try:
        mydb = MSQL.connect(user=user,password=password,
                           host=host, database=database)
        x=False
    except:
        print("Input not accepted")
#read in our csv data to put into SQL
movies = pd.read_csv('movies.csv')
movies = movies[~movies['title'].str.contains("'")]
ratings = pd.read_csv('ratings.csv')
#Ratings needs to be fixed for the timestamp. Next line fixes it
ratings['timestamp'] = pd.to_datetime(ratings['timestamp'],unit='s')
tags = pd.read_csv('tags.csv')

#Now we create a cursor for all our SQL statements
mycursor = mydb.cursor()

'''This section focuses on dropping the tables'''
mycursor.execute("""
                  DROP TABLE MovieGenre;
                  DROP TABLE RatingUserMovie;
                  DROP TABLE TagUserMovie;
                  DROP TABLE Ratings;
                  DROP TABLE Tags;
                  DROP TABLE Username;
                  DROP TABLE Genre;
                  DROP TABLE Movie
                  """)
mydb.close()