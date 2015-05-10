== README

Aucuparia is a simple weblog-like website, with support for multiple users, configurable menus, categories, comments, tags, and a variety of other fun things.

It primarily exists as a project to help the author learn Ruby on Rails. While it is mostly complete, it's probably not suitable for use in any sort of serious environment. Not that you're crazy enough to want to do that, right?

It is released under the MIT license.

== Installation & Configuration

Aucuparia is being developed on ruby 2.1.6, rails 4.2.0, and sqlite3 3.8.8. It requires Imagemagick, Rake, and Bundler. Git is strongly suggested. Once those dependencies are met, it can be set up fairly easily:
    
    $ git clone https://github.com/Sorbus/aucuparia
    $ bundle install

At this point, you'll want to rename config/secrets.yml.example to config/secrets.yml, and db/seeds.rb.example to db/seeds.rb, as well as filling each out appropriately.
    
    $ rake db:migrate
    $ rake db:seed # the current seed-file contains content specific to Aucuparia.net, and should be modified before being used.
    $ rails server
	
Some additional steps must be taken beyond this point to have a functional website, including configuring the server to be accessible to the outside world, daemonizing it (`rails server -d`), and so forth. Rewriting the default CSS to customize the site's appearance is also suggested (in future, I intend to include a minimal version of the CSS to use as a starting point). These are left as an exercise to the reader.

Once an account is created through the web interface it may be marked as a superadmin:

    $ rails console
    > u = User.first # or User.find_by_id('[admin_id]')
    > u.roles << :superadmin
    > u.save

Once at least one superadmin exists, all role management can be done through the web interface.