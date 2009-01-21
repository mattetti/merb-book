# Validaciones de los modelos
La clase ``Sequel::Model`` provee un conjunto de métodos 
para validación de entradas por defecto.
Los métodos de validación estándares disponibles son los siguientes:

 * acceptance\_of (aceptación de)
 * confirmation\_of (confirmación de )
 * format\_of (formato de)
 * length\_of (longitud de)
 * numericality\_of (numerosidad de)
 * presence\_of (presencia de)
 * uniqueness\_of (unicidad de)

Estas validaciones pueden ser especificadas 
de dos maneras dentro de una determinada clase.

    class Usuario < Sequel::Model
    
      validates_confirmation_of :contraseña
      validates_length_of :sobrenombre, :minimum => 5
      
      # o de esta manera
      
      validates do
        confirmation_of :contraseña
        length_of :sobrenombre, :minimum => 5
      end
    end
{:lang=ruby html_use_syntax=true}

Por defecto, ``Sequel::Model`` lanzara un error 
en el caso de fallar en alguna validación de entradas.
El acceso directo de la clase ``:raise_on_save_failure`` puede ser definido como falso 
a fin de evitar el lanzamiento de errores en el caso de error en una validación.
Si ``:raise_on_save_failure`` es falsa, 
entonces el metodo ``#save`` retornara falso en el caso de errores.

Una diferencia importante entre ``Sequel::Model`` y ``ActiveRecord`` es el método ``#save!``.
En el caso de Sequel, este método actualizara la entrada sin validarla.
En el caso de ActiveRecord, este método siempre 
ejecutara las validaciones y lanzara un error si encuentra fallas en este proceso.

En el caso de que falle una validación, 
los errores pueden ser accedidos a través de un objeto con el método ``#errors``.
    
    Usuario.raise_on_save_faliure = false
    usuario = Usuario.new(:sobrenombre => 3)
    usuario.save
    => false
    usuario.errors.on(:sobrenombre)
    => 'is too short'
{:lang=ruby html_use_syntax=true}

Para mas información, por favor referirse a la pagina de [documentación de los Modelos en Sequel][].

[documentación de los Modelos en Sequel]: http://sequel.rubyforge.org/rdoc/classes/Sequel/Model.html
