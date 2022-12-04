# -*- coding: utf-8 -*-
"""
Created on Sat Dec  3 11:59:10 2022

@author: sulli
"""

import mysql.connector as MSQL
import pandas as pd
import streamlit as st
import plotly.express as px
import seaborn as sns

st.title('Movie Dashboard')


st.subheader('Enter Database Connection')
x = True
#This loop gets the information about the database and connects to it
while x:
    user = st.text_input("Enter Username")
    password = st.text_input("Enter Password",type="password")
    host = st.text_input('Enter Host')
    database = st.text_input('Enter Database')
    try:
        mydb = MSQL.connect(user=user,password=password,
                           host=host, database=database)
        x=False
    except:
        print("Input not accepted")

#getting dataframe from view for average movie rating
mycursor = mydb.cursor()
mycursor.execute("""SELECT *
                    FROM AverageMovieRating;
                    """)

result = []
for title, rating, number in mycursor:
    rating_input = float(rating)
    title_input = title.replace("'","")
    result.append([title_input,rating_input,number])    
mycursor.close()

MovieRating = pd.DataFrame(result,columns=['Title','Rating','Number of Reviews'])

#Now we'll get our genre selector dataframe.
mycursor = mydb.cursor()
mycursor.execute("""
                 SELECT movie.title, genre.genre
                 FROM moviegenre
                 LEFT JOIN genre on moviegenre.genreID = genre.genreID
                 LEFT JOIN movie on movie.movieID = moviegenre.movieID;
                 """)

result = []
for title, genre in mycursor:
    title_input = title.replace("'","")
    genre_input = genre.replace("'","")
    result.append([title_input,genre_input])
mycursor.close()

GenreSelector = pd.DataFrame(result, columns=['Title','Genre'])

#Now we'll go through and make the logic for the dashboard




#Genre Selector
st.subheader('Genre Selector')
labels = st.multiselect(
    'Select Genres (No Selection Will Show All)', GenreSelector['Genre'].unique()
)
if len(labels)==0:
    labels = GenreSelector['Genre'].unique()

#Dataframe dash
st.subheader('Dataset')
st.dataframe(MovieRating[MovieRating['Title'].isin(
    GenreSelector[GenreSelector['Genre'].isin(labels)]['Title'].unique())])

#Highest rated movies
st.subheader('Data Visualizations')

df = MovieRating[MovieRating['Title'].isin(
    GenreSelector[GenreSelector['Genre'].isin(labels)]['Title'].unique())]

#Making rated movies vis

'Top 5 Rated Movies'
top_rated = df.sort_values('Rating',ascending=False).head(5)
fig = px.bar(x=top_rated['Title'],y=top_rated['Rating'])
st.plotly_chart(fig)

#Making number of reviews
'Top 5 Most Reviewed Movies'
most_reviewed = df.sort_values('Number of Reviews',ascending=False).head(5)
fig = px.bar(x=most_reviewed['Title'],y=most_reviewed['Number of Reviews'])
st.plotly_chart(fig)