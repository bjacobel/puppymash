####puppymash

Vote on which puppies you think are cuter, and see rankings.

**assignment requirements**

- Takes input from the user in a web form.
	- On the main "playing" page, the app submits a form when you click on one of two images which specifies who was the winner and who was the loser. On the "more" page, the user inputs a number of new puppies to fetch pictures for, and this information is passed in a form to a controller which creates the new model objects.
- Processes that request and saves data in a database.
	- In the first case from above, the data is submitted to a controller which uses the information about who won and who lost together with those two puppies' previous rankings to generate new rankings and save them to the database. In the second case, the request is processed the number of times the user specified and each time a query is made to Flickr to get a new photo, which is saved to the database together with an initial ranking.
- Retrieves data from the database.
	- On every load of the main "playing" page, two puppies are pulled at random from the database and displayed. In the controller which creates new puppies, all puppies are pulled from the database and checked against each time to make sure that picture is unique.
- Produces an output for the user.
	- The "standings" page produces the output of being able to see which puppies are winning, and their corresponding Elo rankings.

#####Setup
The project is dependent on the [flickr_fu](https://github.com/commonthread/flickr_fu) gem, which I have specified in the gemfile. Just run `bundle install` and you should be good to go. There's an included database so you don't have to rate more than a few times to see that it's working, but if you want to start from scratch you can `rm db/development.sqlite3`.

#####Credits
Puppies provided by Flickr and [flickr_fu](https://github.com/commonthread/flickr_fu). Ranking algorithm developed by [Arpad Elo](http://en.wikipedia.org/wiki/Elo_rating_system). Heavily inspired by Mark Zuckerberg's ill-fated "[Facemash](http://vimeo.com/24543171)." 