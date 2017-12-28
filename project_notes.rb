##NOMSTER##
rails v.5.0.6
ruby v2.3.1

#! interesting stuff
#? Questions/check
#* structure
#TODO
#// 

#* Create rails application-----------------
  # rails new nomster --database=postgresql
  # Adjust config/database.yml
  # create initial database
      - rake db:create
  # test server
      - rails server -b 0.0.0.0 -p 3000
#* Setting up webdev pipeline----------------
  # Set up Git
    #? SSH key management
  # Set up Github

#* Deploying to heroku----------------------
  # heroku create nomster-alex-app
  # git push heroku master
  # heroku apps:info
  #! https://nomster-alex-app.herokuapp.com/
  # heroku run rake db:migrate
  # heroku restart
  #TODO: check basic Heroku ninja course

#* Wireframing------------------------------

#* First page-------------------------------
  # create controller
    - rails generate controller places
    #! Rails assumes the controller names are the plural form of the words.
    # add index action
  # update route
    - root 'places#index'
  # create index.html.erb file and add h1

#* Setting model and DB for places-----------
  # generate model place & migration file
    - rails generate model place
    - update migration file & run migration

    #! if correction needed: undo last migration rake db:rollback, adjust migration file & run migration again
    #! caution if code pushed to Github / deployed to prod

#* Listing places on index page
  # update controller - index
      # @places = Place.all
  # update index view ---> Retrieve all places
  # Push to production
      # heroku rake db:migrate
      # heroku run console ---> create a new place -- test ok

#* Bootstrap
  #TODO: Review v4 documentation - https://v4-alpha.getbootstrap.com/
  #* bootstrap-rubygem gem https://github.com/twbs/bootstrap-rubygem
  # update gemfile & run bundle install
=begin       gem 'popper_js', '~> 1.11.1'
      gem 'bootstrap', '4.0.0.alpha6'

      source 'https://rails-assets.org' do
        gem 'rails-assets-tether', '>= 1.3.3'
      end
 =end 
      # restart server
      # rename application.scss
      # create master.scss
        @import "bootstrap";
      # update application.js
        to include popper, tether, and bootstrap-sprockets between turbolinks and require_tree . 
        #! Order of this code is important. 
        popper must be placed between turbolinks and tether.
      
#* Navigation
      #* Add and edit navigation to application.html.erb - code from bootstrap
#* Editing Index
#TODO: GRID SYSTEM: https://v4-alpha.getbootstrap.com/layout/grid/

#* Adding background patterns and fonts
      #! http://subtlepatterns.com/
      #! add image to body as background-image: url('round.png')
      #! add background to navbar
      # add box-shadow to navbar
      # Update font stack
        # simple font change - css font declaration
        # google font
          #! import in master.css
          @import url(https://fonts.googleapis.com/css?family=Open+Sans+Condensed:300);

      #! push to Heroku -- Issue with image rendering
        in environment/production.rb - added:
          config.serve_static_assets = true
          config.assets.compile = true

#* Add pagination -  Will_paginate
      # Add gem
      # bundle install
      # update controller places
        - @places = Place.order("name").page(params[:page]).per_page(5)
      # update index view page

      #?: Could you please clarify where the .pagination class originates (refer screen shot pagination1.png). I assume this comes from the Bootstrap import. 
      #?: if assumption is correct, how do I access the relevant stylesheet to amend the pagination style ? 
      #?: I want to align the pagination and booyah-box width. Do you have recommendation ? 
      #?: As it is, the pagination bar is not fixed which is sub-optimal and downright ugly when the page displays less than 5 elements. 
      Any recommendation on how to fix this element ? (refer screenshot pagination2.png)


      http://hopeful-liskov-fe3f88.netlify.com/admin/#/collections/pages
      gosher123

