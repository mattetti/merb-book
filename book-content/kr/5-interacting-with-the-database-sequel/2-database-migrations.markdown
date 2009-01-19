#데이터베이스 마이그레이션

모델을 생성하는 merb-gen 명령을 입력하면 Sequel 마이그레이션도 생성됩니다.

    $ merb-gen model post
    Generating with model generator:
         [ADDED]  spec/models/post_spec.rb
         [ADDED]  app/models/post.rb
         [ADDED]  schema/migrations/001_post_migration.rb
         
    $ cat schema/migrations/001_post_migration.rb
    
    # Sequel 마이그레이션에 대한 자세한 내용은 
    # http://sequel.rubyforge.org/를 참조하시기 바랍니다.

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
    
칼럼들은 `#column` 메소드를 이용하여 테이블정의에 더해질 수 있습니다.
또는 칼럼타입을 메소드로서 직접 기술 할 수 있습니다.

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
    
마이그레이션을 편집한 후, 마이그레이션은 rake task로 실행할 수 있습니다.
    
    $ rake sequel:db:migrate

특정 마이그레이션 버전으로 롤백하기 위해 VERSION 플래그를 사용할 수 있습니다.