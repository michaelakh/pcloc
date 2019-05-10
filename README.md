# PostCode Locator

Description: A Very simple app, Insert offices into a database, and as long as there's a postcode, it will find long and lat and save that to the database

Then on the index page, you can search via distance in miles for closest office that exists in the database

## SETUP

### Part 1
Clone directory into your desired location

```
git clone https://github.com/michaelakh/igstories.git
```
Go into the app directory
```
cd pcloc
```
Install and update bundles
```
bundle install
bundle update
```
### Part 2
Install and configure Postgresql

if you have postgresql installed skip to Part 3

if you don't have postgresql installed... and you're on linux run

```
sudo apt-get install postgres
```

this will get most recent version
then run
```
sudo -u postgres -i
```
to get into your postgres database
and run
```
createuser 'your username here' --superuser
```

then check the database.yml file and under defaults make sure there's
* username: 'your usermame here'

### Part 3
Create and migrate the database
```
rake db:create
rake db:migrate
```
### Part 4 
Start the server
```
rails s
```
Now use the app, add some data in and test to see if you can return location within 2 points

