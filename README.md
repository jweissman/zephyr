# Zephyr

A game programming framework in Ruby and Rails, using Backbone.js and Faye for front-end synchronicity.

(We'll see how long all that holds up performance-wise. But given that the updates are fairly 'lazy'...)

Currently, the root points at a 'full of stars' proof of concept, which displays some canvas entities that
can be created with a click (and which async update for anyone on the page.)

Looking to include a simple pong and asteroids style game.

One goal for this is to try to help extract the platform we'll need for larger systems.


# Requirements

To run the specs or fire up the server, be sure you have these:

* Ruby 1.9.3-p327
* PostgreSQL 9.x with superuser 'postgres' with no password (```createuser -s postgres```)
* PhantomJS for JavaScript testing (```brew install phantomjs```)

# Development

### First Time Setup

After cloning, run these commands to install missing gems and prepare the database.

    $ gem install bundler
    $ bundle update
    $ rake db:setup db:sample_data

Note, ```rake db:sample_data``` loads a small set of data for development. Check out ```db/sample_data.rb``` for details.

### Running the Specs

To run all ruby and jasmine specs.

    $ rake

Again, with coverage for the ruby specs:

    $ rake spec:coverage

### Running the Application Locally

    $ foreman start
    $ open http://0.0.0.0:3000"

### Using Guard

Guard is configured to run ruby and jasmine specs, and also listen for livereload connections. Growl is used for notifications.

    $ bundle exec guard

### Deploying to Heroku

Install the heroku toolbelt if you don't already have it (https://toolbelt.heroku.com/).

    $ heroku apps:create zephyr
    $ git push heroku master
    $ heroku run rake db:setup

# Considerations

...
