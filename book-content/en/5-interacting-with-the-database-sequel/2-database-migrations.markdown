#Database Migrations

Sequel migrations will be generated with any merb-gen task that creates a model.

    $ merb-gen model post
    Generating with model generator:
         [ADDED]  spec/models/post_spec.rb
         [ADDED]  app/models/post.rb
         [ADDED]  schema/migrations/001_post_migration.rb
         
    $ cat schema/migrations/001_post_migration.rb
    
    # For details on Sequel migrations see 
    # http://sequel.rubyforge.org/

    class PostMigration < Sequel::Migration

      def up
        create_table :posts do
          primary_key :id
        end
      end

      def down
        drop_table :posts
      end

    end
    
Columns can be added to the table definition using the `#column` method or the column type can be used as the method in the specification.

    class PostMigration < Sequel::Migration

      def up
        create_table :posts do
          primary_key :id
          string      :title
          text        :body
          boolean     :published, :default => false
        end
      end
      
      def down
        drop_table :posts
      end

    end
    
After editing the migration, it can be run with a rake task.
    
    $ rake sequel:db:migrate

A VERSION flag can be specified to roll back to particular migration versions.

A database for the test environment will not built automatically.
To run tests, the test database will need to be migrated as well.
A MERB\_ENV variable can be passed to the rake task.

    $ rake sequel:db:migrate MERB_ENV=test