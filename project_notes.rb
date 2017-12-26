##NOMSTER##
rails v.5.0.6
ruby v2.3.1

#! interesting stuff
#? Questions/check
#* structure
#TODO

#* Create rails application-----------------
  # rails new nomster --database=postgresql
  # Adjust config/database.yml
  # create initial database
      rake db:create
  # test server
      rails server -b 0.0.0.0 -p 3000
#* Setting up webdev pipeline----------------
  # Set up Git
    #? SSH key management
  # Set up Github

#* Deploying to heroku----------------------
  # heroku create nomster-alex-app
  # git push heroku master
  # heroku apps:info
  #TODO: check basic Heroku ninja course

#* Wireframing------------------------------

#* First page-------------------------------
  # create controller
    rails generate controller places
    #! Rails assumes the controller names are the plural form of the words.
    # add index action
  # update route
    root 'places#index'
  # create index.html.erb file and add h1

#* Setting model and DB for places-----------
  # generate model place & migration file
    rails generate model place
    update migration file & run migration


