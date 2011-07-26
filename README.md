Remark
======

Introduction
------------

Remark is a simple blogging tool & a work in progress.

Still To Come
-------------

- Searching.
- Themes.
- Archive & tag browsing.
- Plugins (possibly).

Setup
-----

### Development

Download or clone and run the following commands:

	bundle install --without production
	rake db:migrate
	rake db:seed
	rails server

Navigate to _http://localhost:3000/admin_ and login using the default credentials:

	admin
	password
	
Go to the _users_ tab and change your password (and username if you feel like it).

### Production

Download or clone, setup _config/database.yml_ (production mode defaults to MySQL) and run the following commands:

	bundle install
	rake db:migrate RAILS_ENV=production
	rake db:seed RAILS_ENV=production
	
Run the server of your choice (I recommend [Phusion Passenger](http://www.modrails.com/)).

Navigate to _http://yourserver.com/admin_ and login using the default credentials:

	admin
	password
	
Go to the _users_ tab and change your password (and username if you feel like it).

### Heroku

Download or clone and run the following commands:

	rake remark:heroku:setup
	bundle install
	git add Procfile
	git commit -a -m "Ready for Heroku."
	heroku create --stack cedar
	git push heroku master
	heroku run rake db:migrate
	heroku run rake db:seed
	
Navigate to _http://your-app-000.herokuapp.com/admin_ and login using the default credentials:

	admin
	password

Go to the _users_ tab and change your password (and username if you feel like it).

Next Steps
----------

Start blogging.

License
-------

All of my code is licensed under the terms found in the LICENSE file, the license is essentially based
on the BSD new license but breaks down into the following points;

1. You can use the code wherever you wish.
2. You can modify the code as much as you want and use the modified code wherever you wish.
3. You can redistribute the original, unmodified code, but you have to include the full license text.
4. You can redistribute the modified code as you wish (without the full license text).
5. In all cases, you must include an attribution mentioning Alex Pardoe as the original creator of the source.
6. I’m not liable for anything you do with the code, no matter what. So be sensible.
7. You can’t use my name or other marks to promote your products based on the code.