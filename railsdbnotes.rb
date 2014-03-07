#create new project with name of project_name
rails new project_name
cd project_name
#open sublime
sublime *
#db_table_name should be singular!!
rails g model Db_Table_Name column:type num_column:integer str_column:string
#to update a table model do so in the models model_name.rb file

#create the migration file
#not necessary unless no sqlite3--> rake db:create

#execute the migration file
#NOTE: can migrate multiple times if migration file changes need to be saved
rake db:migrate
#IF YOU MAKE A MISTAKE AND NEED TO DELETE A MIGRATION FILE FROM DB
bundle exec rake db:rollback
rails destroy model model_name

#TO DELETE MORE STUFF
rails destroy controller lalala
rails destroy model yadayada
rails destroy scaffold hohoho
#and so on and so forth....


#rollback the last command, remove table from db
rake db:rollback
#open the rails console
rails c

#commit to database like this
s = Db_Table_Name.new
s.str_column = "string"
s.num_column = 3
s.save

#or commit this way too
Db_Table_Name.create(:column=> value, :str_column=> "thestring", :num_column=> 45)

#or commit this way for multiple identical commits

50.times do |x|
	Db_Table_Name.create(:column=>value, :str_column=>"thestring", :num_column=>45)
end

#or make an extension of a db_table
ex: 
#this one does not extend
rails g model Trooper health:integer speed:integer damage:integer 
#whoops made a mistake, update last input, this one extends spartan table
rails g model Trooper health:integer speed:integer damage:integer spartan:references --force



#then.....
Spartan.first.troopers.create(:health=>5....etc...)
#more creations....
Thismodel.find(2).posts.create(:title=>'taoi', ....)
Thismodel.last.messages.create(...)
Thismodel.find_by(:title=>'this_title').posts.create()
Thismodel.find_by_id().posts.create()
Thismodel.find_or_create_by(:id )

User.find_by(:id => [1,3,2,4]).blogs.create(:name=>'thaoi',:description=>'aiho oaihf aoihaf aoh aofihaf aohfa ifuhaif o')
#or to populate many at once
(1..5).each do |x|
	User.find(x).blogs.create(:name=>'aihoa',:description=>'ahio haig ha ioa aioha haio')
end


#enable Hirb to view data in clean format within prompt(not necessary but looks nice)
	#need to download hirb gem first if you do not have it already installed

#if you want, install hirb every time you make a new project
#put this in your gem file
gem "hirb", "~> 0.7.1"
#then go in the console
bundle install
#go into rails console
rails c
require('Hirb')
Hirb.enable






#get all dem troopas
Trooper.all
#get first
.first
#get last
.last
#how to get all info on 3 records from table with first_name column(order by first_name desc limit 3)
Db_Table_Name.all.order('first_name DESC').limit(3)
#get record of user with id of 3
Db_Table_Name.where('id = 3')
#Select from the columns dance_style and smell for all records in table with id greater than 2 ordered by created_at ascending
Db_Table_Name.select('smell, dance_style').where('id > 2').order('created_at ASC')
#find whether a particular person exists in db
Db_Table_Name.where(first_name: 'Ryan').exists?
#will return true if any one of these three exists
Db_Table_Name.exists?(1,2,3)


#UPDATING A RECORD
user = User.find_by(first_name: 'David')
user.name = 'Dave'
user.save

user = User.find_by(first_name: 'David')
user.update(first_name: 'Dave')

#DELETE A RECORD
user = User.find_by(first_name: 'David')
user.destroy

User.destroy_all(:name => 'thisname')
User.where(:id => [1,2,3,4,5]).destroy_all
User.where(:id => 1..5).destroy_all

#dont confuse yourself with these ones
User.where(:id => param[:ids]).destroy_all
users?ids[]=1&ids[]=2&ids[]=3

#VALIDATIONS
  validates :title, :content, :presence => true
  validates :title, :length=> { :minimum=>7, :maximum=>200 }
 #havent tried these but they should work
  validates :password, :length=>{ :in=>6..20 }
  validates :registration_number, :length=>{:is=>6}

  #email validation
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i 


#ASSOCIATIONS

#so things can get tricky here, when doing associations, in your corresponding model/model_name.rb files you need to declare the relationship that occurs in the table. For example: 
belongs_to :dojo
has_many :ninjas
has_one :ninja
#to add posts through another table you must have the relationship declared
has_many :weapons
has_many :injuries, :through=>:weapons
#or
has_many :weapons
has_many :injuries, through :weapons

#so on the injury end, in order to utilize the association you would need
has_many :weapons
has_many :injuries, :through=>:weapons


#POLYMORPHISM

#generate the model that you want to be referenced in multiple instances
#NOTE the commentable table does not actually exist, it is the polymorphic reference for all the other tables
rails g model comment title:string comment_content:text commentable:references{polymorphic}
rake db:migrate

#in the other tables' model/model_name.rb files you will reference the comment table as commentable
#In message, ex:
has_many :comments, as: :commentable

#MORE USEFUL GEMS

gem 'simple_form'
gem 'rails-footnotes', '>=3.7.9', :group => :development
gem 'bootstrap-sass', '~>2.3.1.0'

#install the gems
bundle install
#run the generator(s)
#for simple form 
rails g simple_form:install
#for rails footnotes
rails g rails_footnotes:install


#in your controller.css.scss file, you will need to import bootstrap
@import "bootstrap";


#R SPEC

#Add the following to your Gemfile:

group :development, :test do
  gem 'rspec-rails'
end
#Run the following to your Terminal:

bundle install
rails generate rspec:install

#Spec directory will be added to your project's root directory. 
#Spec directory will have spec_helper.rb file that contains your RSpec configurations. 
#Start a RSpec testing by running the following to your Terminal.
rspec spec

#check if a spec file is valid by running something like
rspec spec/models/contact_spec.rb

#SCAFFOLDING
#EITHER BY AUTO OR MANUAL

#show routes in command line
rake routes

#in your routes.rb file within the config folde, comment out any gets and put
resources :controller_name

#generate new scaffold
rails g scaffold monkey name:string banana:integer fleas:boolean


