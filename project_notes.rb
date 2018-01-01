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
#* USER AUTHENTICATION - DEVISE
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