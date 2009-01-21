# Migraciones hacia la base de datos
Las migraciones en Sequel serán generadas por 
cualquier tarea del comando ``merb-gen`` que cree un modelo.

    $ merb-gen model articulo
    Generating with model generator:
         [ADDED]  spec/models/articulo_spec.rb
         [ADDED]  app/models/articulo.rb
         [ADDED]  schema/migrations/001_articulo_migration.rb
    $ cat schema/migrations/001_articulo_migration.rb
{:lang=shell html_use_syntax=true}
    
    class ArticuloMigration < Sequel::Migration
      def up
        create_table :articulos do
          primary_key :id
        end
      end

      def down
        drop_table :articulos
      end
    end
{:lang=ruby html_use_syntax=true}
    
Usted puede agregar columnas a la definición de una tabla determinada 
utilizando el método ``#column`` o también puede definir el tipo de columna 
como un método en la especificación de la tabla en cuestión.

    class ArticuloMigration < Sequel::Migration
      def up
        create_table :articulos do
          primary_key :id
          string :titulo
          text :cuerpo
          boolean :publicado, :default => false
        end
      end
      
      def down
        drop_table :articulos
      end
    end
{:lang=ruby html_use_syntax=true}

Luego de haber modificado la migración, 
usted debe ejecutar el siguiente comando.    
    
    $ rake sequel:db:migrate
{:lang=shell html_use_syntax=true}

Una bandera de versión de la migración puede ser especificada 
con el fin de volver a una determinada versión de migración.

Para mas información, por favor referirse a la página del [proyecto Sequel][].

[proyecto Sequel]: http://sequel.rubyforge.org/
