# Asociaciones entre modelos
La clase ``Sequel::Model`` tiene un conjunto simple de métodos de asociación.
Sequel provee los siguientes métodos para crear asociaciones en la base de datos:
 
 * ``one-to-one`` (uno-a-uno)
 * ``many-to-one`` (muchos-a-uno)
 * ``one-to-many`` (uno-a-muchos)
 * ``many-to-many`` (muchos-a-muchos)

A continuación se detallara cada uno de los métodos mencionados.

## Uno a Uno

    class Usuario < Sequel::Model
      one_to_many :direcciones, :one_to_one => true
    end
{:lang=ruby html_use_syntax=true}

## Uno a Muchos

    class Artículo < Sequel::Model
      one_to_many :comentarios
    end
{:lang=ruby html_use_syntax=true}

La clase ``Artículo`` ahora tiene un conjunto de métodos de asociación
similar al método ``has\_many`` proporcionado por ActiveRecord.

## Muchos a uno

    class Artículo < Sequel::Model
      many_to_one :usuario
    end
{:lang=ruby html_use_syntax=true}

## Muchos a Muchos
    
    class Artículo < Sequel::Model
      many_to_many :tags
    end
{:lang=ruby html_use_syntax=true}
