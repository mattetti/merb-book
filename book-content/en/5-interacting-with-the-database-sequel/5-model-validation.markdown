#Model Validation

Sequel::Model provides a set of validation methods by default.
The available standard validations are:

 - acceptance\_of
 - confirmation\_of
 - format\_of
 - length\_of
 - numericality\_of
 - presence\_of
 - uniqueness\_of
  
Validations can be specified in two ways within a class.

    class User < Sequel::Model
    
      validates_confirmation_of :password
      validates_length_of :login, :minimum => 5
      
      # or
      
      validates do
        confirmation_of :password
        length_of :login, :minimum => 5
      end
    end

By default, Sequel::Model will raise an error on validation failures.
The class accessor `:raise_on_save_failure` can be set to false to avoid raising errors on validation failure.
If `raise_on_save_falure` is false, the `#save` method will return false on failures

An important distinction between Sequel::Model and ActiveRecord is the `#save!` method.
In Sequel::Model, `#save!` will update the record without validation.
This is significantly different from ActiveRecord, which will run validations and raise an error on failure.

If validation fails, errors can be accessed on the object with the `#errors` method.
    
    User.raise_on_save_faliure = false
    u = User.new(:login => 3)
    
    u.save
    => false
    u.errors.on(:login)
    => 'is too short'
   
A full set of documentation for model validations can be found in the [Merb::Sequel documentation][]

    
[Merb::Sequel documentation]: http://sequel.rubyforge.org/rdoc/classes/Sequel/Model.html