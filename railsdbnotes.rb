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
#enable Hirb to view data in clean format within prompt(not necessary but looks nice)
	#need to download hirb gem first if you do not have it already installed
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


