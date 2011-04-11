## B-Town Events

### A Senior Project by Matt Sacks, Cameron Davis, and Ro Tlusty

Simple web and mobile-web app for displaying what's happening in Bloominton. Browse by week, day, different categories, or just see more info about different places.

### Technical

To install, make sure you have [rvm](https://rvm.beginrescueend.com/) with RubyGems installed. It also helps to have [git](http://git-scm.com/). Installation will vary depending on your OS.  

Then run: `gem install bundler && bundle install`  

Use `rake db:real` to import from the `db/Events Schedule.csv` and `db/Facilities.csv` into the database.
