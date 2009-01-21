# Extensiones de Sequel
La clase ``Sequel::Model`` puede ser vista 
como el mínimo conjunto de funcionalidades para un ORM, 
pero es realmente fácil de extender sus capacidades.
Las extensiones son librerías empaquetadas como gemas 
las cuales pueden agregar funcionalidades necesarias a sus modelos.
Estas extensiones deberán ser llamadas como ``sequel_nombreextension``.
Estas son utilizadas en un modelo al declarar ``is :nombreextension``.
Las extensiones son muy fáciles de usar como de escribir.

## Extensiones útiles.
###sequel\_timestamped
Como el nombre lo indica, ``sequel\_timestamped`` actualizará
las columnas ``timestamp`` estándares de su modelo.

    class Nota < Sequel::Model
      is :timestamped
    end
{:lang=ruby html_use_syntax=true}

En el caso que el modelo haya creado 
las columnas de tiempo ``created_at`` y ``updated_at``, 
ellas serán actualizadas automáticamente.

Para más información, por favor referirse a la 
página de la [extension sequel\_timestamped][].

###sequel\_notnaughty
Esta extensión reemplaza las validaciones estándar de la clase ``Sequel::Model``
con un conjunto de validaciones sintácticamente no sucias.
Esta extensión es una gema que provee 
una plataforma de validaciones fácilmente extensible.
    
    class Usuario < Sequel::Model
      is :notnaughty
      
      # Ahora usted podrá utilizar la sintaxis no sucia para sus validaciones.
      validates do
        presence_of :sobrenombre
        length_of :sobrenombre, :minimum => 5
      end
    end
{:lang=ruby html_use_syntax=true}

Para más información, por favor referirse a la 
página de la [extension sequel\_notnaughty][].

###sequel\_polymorphic
Esta extensión se encarga de definir las asociaciones polimórficas
agregando funcionalidades al manejo de asociaciones de Sequel.

    class Nota < Sequel::Model
      is :polymorphic
      one_to_many :activos, :as => :attachable
    end

    class Activo < Sequel::Model
      is :polymorphic
      many_to_one :attachable, :polymorphic => true
    end
{:lang=ruby html_use_syntax=true}

Esto creara una relación polimórfica transparente 
entra una nota y sus respectivos activos.

Para más información, por favor referirse a la 
página de la [extension sequel\_polymorphic][].

###sequel\_taggable
Esta extensión fue desarrollada por Jack Dempsey 
mientras se encontraba trabajando con Merb.
Esta se encarga de agregar simples rótulos a un determinado modelo.
Por el momento, no existen tareas en la extensión para generar una tabla Rotulo
aunque si existe una migración, la cual viene incluida en el código fuente de la misma.

    class Artículo < Sequel::Model
      is :taggable
    end
    
    artículo = Artículo.create(:titulo => "Mi primer articulo")
    rótulo = Tag.create(:name => "un rótulo")
    articulo.add_tag(rotulo)

Esta extensión depende de la extensión ``sequel\_polymophic``.

Para más información, por favor referirse a la 
página de la [extensión sequel\_taggable][].

[extensión sequel_timestamped]: http://github.com/bricooke/sequel_timestamped/tree/master
[extensión sequel_notnaughty]: http://github.com/boof/sequel_notnaughty/tree/master
[extensión sequel_polymorphic]: http://github.com/jackdempsey/sequel_polymorphic/tree/master
[extensión sequel_taggable]: http://github.com/jackdempsey/sequel_taggable/tree/master
