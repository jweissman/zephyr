# Zephyr [![Codeship Status for jweissman/zephyr](https://www.codeship.io/projects/3c3dbf20-6665-0130-f564-22000a9d0597/status?branch=master)](https://www.codeship.io/projects/1740) [![Code Climate](https://codeclimate.com/github/jweissman/zephyr.png)](https://codeclimate.com/github/jweissman/zephyr)

A game programming framework in Ruby and Rails, using Backbone.js and Faye for front-end synchronicity.

# Full of Stars

Currently, the root points at a 'full of stars' proof of concept, which displays some canvas entities that can be
created with a click. These entities sync with Rails, which in turn talks to Faye, which then broadcasts an update to
clients so that the star field async updates for anyone on the page.

It might be especially interesting to watch the #destroy_all operation running over the stars -- you can watch them
wink out! Note all this does require having a running Faye server somewhere in the cloud (a link to a suitable OpenShift
DIY instance running Faye are below.)

It's all relatively fast, as such things go, but I think we'll definitely want to limit the number of model changes we
 want to observe server-side. Eventually we're looking to include a few "classic" game demos like Pong and a roguelike
 example, maybe using rot.js. One goal for this is to try to help identify and extract the platform and services we'll
 need for larger multiplayer systems.

# Multiplayer Pong

This is the next major target. We're currently building out a node.js 'game' server which can keep track of

- the lobby and matchmaking services, and
- simulation (authority over) game state

With this in place we should be able to setup games and arbitrate them with an independent server process. Eventually it would be nice to extend this to doing things like auditing client logs for cheating, etc.

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

Note, ```rake db:sample_data``` loads a small set of data for development.

(Check out ```db/sample_data.rb``` for details.)

### Running the Specs

To run all ruby and jasmine specs.

    $ rake

Again, with coverage for the ruby specs:

    $ rake spec:coverage

### Running the Application Locally

    $ foreman start
    $ open http://0.0.0.0:3000"

### Using Guard

Guard is configured to run ruby and jasmine specs, and also listen for livereload connections.

Growl is used for notifications.

    $ bundle exec guard

### Deploying to Heroku

Install the heroku toolbelt if you don't already have it (https://toolbelt.heroku.com/).

    $ heroku apps:create zephyr
    $ git push heroku master
    $ heroku run rake db:setup

Note that heroku doesn't support websockets (!) so you'll need to run Faye elsewhere. As luck would have it, Openshift
lets you handle websockets, but you do have to set a DIY instance. This is actually relatively straightforward and I am
happy to share details if anyone is interested.

Since it's part of our "infrastructure" now I'll try to document it a bit more carefully in the wiki eventually, but
I've gone ahead and put my DIY folder structure [up on Github](https://github.com/jweissman/zephyr-faye-diy) in case
anyone else wants to repurpose it.

# Considerations

Andrew Kasper (@akasper) -- review/consultation/testing
...
