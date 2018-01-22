# README


A Very simple app, Insert some data, and as long as there's a postcode, it will find long and lat and save that to the database

* Then on search it finds all results within what ever range you want

* Although i made it a select for with the values 5,10,15,25,50,100 miles for simplicity

* I left comments in the code to tell you exactly what each function of the code does

* Although i did not comment the views because I felt like that would be too much. The views use partials and instance variables to get the data.

* I also use bootstrap and a little custom css to get it to look semi-decent.. if i had more time and more to go on, it would have been a great looking website :)

SETUP

cd into this app directory
run
* bundle install
* bundle update

go to database.yml file and configure postgresql database to your specifications

then run

* rake db:create
* rake db:migrate

Now use the app, add some data in and test to see if you can return location within 2 points

