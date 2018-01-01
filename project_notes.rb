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

#* Building form for place submission
        # update places routes
          - resources :places
        # add new action in places controller
        # create new.html.erb view
        # Install simple_form
          #! https://github.com/plataformatec/simple_form
          # bundle install
          # rails generate simple_form:install --bootstrap
          # Create form
          #! The browser doesn't know how to interpret things with simple form, because ruby 
          #! converts the simple form inputs into regular HTML elements, that the browser does 
          #! know how to interact with in the process of serving up the app.

#* Commit new places and save to DB
  #First, store the place in DB , with the data the user entered.
  #Second,send the user to root page
  
  # Add create action in controller
    def create
      Place.create(place_params)
    end

    private
      def place_params
        params.require(:place).permit(:name,:description,:address)
      end
  #! The place_params part is what pulls the values of name, description and address from the place form. 
  #! Then the Place.create is what actually sends the item to the database.

  #* Add links and font awesome
      # Brand link to root_path
      # Link to new_place_path
      # Font awesome
        # gem "font-awesome-rails"
        # master.scss --- @import "font-awesome";
        #TODO:http://api.rubyonrails.org/classes/ActionView/Helpers/UrlHelper.html#method-i-link_to
        #! integrate fontawesome icon in link
          <%= link_to new_place_path , class:"nav-link" do %>
            <i class= "fa fa-plus-circle"></i>
            New Place
          <% end %>
        #! push to prod. ---> ok
#* 16. USER AUTHENTICATION - DEVISE
          # install Devise & bundle install
          # rails generate devise:install
            ## STEP.1 Setting up default url options - mailer configuration
              ### config/environments/development.rb
              add config.action_mailer.default_url_options = { host: 'localhost:3030' }
              We access our dev environment at localhost:3030 (in Vagrant) rather than 3000. 
              So we need to adjust the host url to match our environment.

              ### config/environments/production.rb --- adjust our production
              #! adjust to match our heroku host
              #! heroku apps:info --- to retrieve this information
              config.action_mailer.default_url_options = { host: 'nomster-alex-app.herokuapp.com' }
            
            ## STEP.2 Setting up root url --- ok

            ## STEP.3 Flash Messages
            flash = is a place we can store messages we want to present the user, like notifications, alerts
              #! refer Splurty 14
              # Add flash to application.html.erb
                <p class="notice"><%= notice %></p>
                <p class="alert"><%= alert %></p>
              # Add some bootstrap styling
              #! The downside to the bootstrap styling - status boxes displayed even though there is no status to be displayed
              # Solution - Conditional display logic
                <% if notice.present? %>
                  <p class="alert alert-info"><%= notice %></p>
                <% end %>
                <% if alert.present? %>
                  <p class="alert alert-danger"><%= alert %></p>
                <% end %>
              
              ## STEP.4 Generate Devise views
                # rails generate devise:views
              
              ## STEP.5 Generate User model
                # rails generate devise User
                # rake db:migrate

#* 17. Testing user login and adding user links to navbar
  #TODO: check Devise documentation
    #! before_filter :authenticate_user!  -->  to require that a user is authenticated before accessing a page
    #! current_user --> access the current signed-in user
    #! user_signed_in? --> check to see if a user is signed in
  # Update Nav - Conditional links display - if user_signed_in?

#* 18. Connect users to Places
  # require that only users who are signed in can create a place. 
  # Store information in the database to allow us to keep track of the user that created each specific place.

  #STEP.1 - Only logged-in user can create Places
  In our application we should allow anyone to view the places that we have in the database. 
  However we should only allow users who are signed-in to add places to our application. 
  This means in our application we should block the new and create actions to only be usable by signed-in 
  (also known as authenticated) users.

  #! before_action :authenticate_user! -- Before filters are code that executes before the code in our controller runs
  #! before_action :authenticate_user!, only: [:new, :create]
  # In this case we want to require a user to be logged in only for the new and create actions
  # With the before filter implemented, anyone who is not logged-in will be redirected to the 
  # login page when clicking on the 'New Place +' link in the top nav. 
  # After the user is logged in, they're allowed to access the "New Place" page

  #STEP.2 Store current userId on the Place model upon record creation
  Now that users have to be signed in, to create a new place, we should store their User's id together with the place they created. 
  That way we know which user created what place.
  Up until now, our database tables were not linked to each other and were completely separated. 
  Now we will change this and connect our places and users database tables. 
  This is one of the most powerful features of SQL (the language of databases). 
  We will be able to reference a record in one table in an entirely different table

  So how will we do that? We're going to need to start by creating another column in the places database table. 
  Anytime we want to create new columns in our database, we need a migration
  #! rails generate migration alter_places_add_user_id_column
  #! update migration 
    add_colum :places, :user_id, :integer
    add_index :places, :user_id #Best practice to add index col to fasten lookup process
  
  #STEP.3 Connecting places to users - DB Association
    #Update models with association
      # place: belongs_to :user
      # user: has_many :places
    #Now we have access to lookups
      User.first.places
      Place.first.user
    #Update places controller -- "create a place that is connected with this user",
      def create
        current_user.places.create(places_params)
      end
      This is something that we're allowed to do because we said in our user.rb model that it has_many :places, 
        so it knows these two things are linked up and rails magic like this can happen
    #Add user email to index page - conditional display
        <% @places.each do |place| %>
          <div class="booyah-box col-10 offset-1 place-items">
            <h1><%= place.name %></h1>
            <i><%= place.address %></i><br /><br />
            <p><%= place.description %></p>
            #!<% if place.user.present? %>
              <small><%= place.user.email %></small>
            <% end %>
          </div>
        <% end %>
    # Update places table with user_id information
      #! Place.where(user_id: nil).update_all(user_id: User.first.id)