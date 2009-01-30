#Setting Up DataMapper

* This will become a table of contents (this text will be scraped).
{:toc}


## Configure the Database Settings
Database settings are found in <tt>config/database.yml</tt>. 

If you want to use sqlite3 for everything, you shouldn't have to change anything. Move on with this section. 

### Everything MySQL
If you want everything to use mysql, then where it says:

    development: &defaults
      # These are the settings for repository :default
      adapter:  sqlite3
      database: sample_development.db
change to

    development: &defaults
      adapter: mysql
      database: app_name_development
      username: user
      password: pass
      host: localhost
Realistically, everything but the adapter and host lines can be whatever you want, as long as you have mysql setup the recognize the user. 

### Only Production MySQL
If you just want production to use MySQL, then leave the development part alone, but change the part that says

    production:
      <<:       *defaults
      database: production.db
to

    production:
      adapter: mysql
      database: app_name_development
      username: user
      password: pass
      host: localhost
#### NOTE
MySQL and SQLite have some slight differences. MySQL might get errors with certain types not setup right that SQLite doesn't get. So you should do a little testing to make sure that MySQL is happy with all of your fields before you go live. 

TODO Talk about setting up other DBs. 