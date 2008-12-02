module MerbBabel
  
  module HashExtension

    def symbolize_keys
      inject({}) do |options, (key, value)|
        options[key.to_sym || key] = value
        options
      end
    end
    
    def symbolize_keys!
        self.replace(self.symbolize_keys)
    end
    
    def valid_localization_hash?
      self.has_key?(:mloc_language_code)
    end
    
    def localization_hash_with_locale?
      self.has_key?(:mloc_country_code)
    end

  end

end


Hash.send :include, MerbBabel::HashExtension
