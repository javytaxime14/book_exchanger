# README #

Book Exchanger is a project created to help users to manage and share their book collection, and to make a list of books they want to read. It also allows them to make exchanges with other users (as a register) and add them as friends.


ruby version: 2.7.4
Rails version: 5.2.6


## Starting 

### Check out the repository 
$ git clone https://github.com/javytaxime14/book_exchanger.git


Create your application databases by using the rails command: 
$ rails db:create
$ rails db:setup


Then you must install the gems:
$ bundle install


### Testing Your Configuration
bundle exec rails s
And now you can visit the application in your browser: http://localhost:3000/


### Deployment
Log in to heroku and run the database:
$ heroku restart
$ heroku run rake db:migrate
$ heroku run rake db:seed

then run heroku open


You can also visit the application following the address: www.book-exchanger.cl


To log in as **admin** use the following route: http://localhost:3000/admin/login and use the following **credentials**:


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')


Enjoy!
...
