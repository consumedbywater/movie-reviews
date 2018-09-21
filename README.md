# README

A basic movie review site

This site is built in Ruby on Rails using PostgreSQL as a backing database.

It uses an API provided by The Movie Database to get movies.

Currently, the sort by title option on the homepage doesn't appear to be
working, but that's a result of the API. Currently, the API will return
titles sorted by their original title and language, so when translated
to English the sorting is incorrect. I haven't yet found a better request
to achieve this task.

The sort by release date option also returns odd results. The Movie Database
holds movies that haven't yet been released, so when sorting by release date
a number of unreleased movies are presented with expected release dates.
There is a request to get movies released before a certain date that could
be used to resolve this issue, but I chose not to include it in this version
of the website. I may later add an option to filter out future release dates.

There's a live version of the website hosted at:
http://bar-movie-reviews.herokuapp.com/