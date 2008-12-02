require File.join(File.dirname(__FILE__) / "merb_babel" / "core_ext")

# make sure we're running inside Merb
if defined?(Merb::Plugins)

  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:merb_babel] = {
    :default_locale => 'en-US',
    :default_language => 'en',
    :default_country => 'US',
    :localization_dirs => ["#{Merb.root}/lang"]
  }
  
  require File.join(File.dirname(__FILE__) / "merb_babel" / "m_locale")
  require File.join(File.dirname(__FILE__) / "merb_babel" / "m_l10n")
  require File.join(File.dirname(__FILE__) / "merb_babel" / "m_i18n")
  
  Merb::BootLoader.before_app_loads do
    # require code that must be loaded before the application
    module Merb
      module GlobalHelpers
        include ML10n

        # Used to translate words using localizations
        def babelize(key, *args)
          options = args.first 
          options ||= {}
          options.merge!(:key => key)
          options.merge!(:language => language) unless options.has_key?(:language)
          options.merge!(:country => country) unless options.has_key?(:country)
          MI18n.lookup(options)
        end
        alias :translate :babelize
        alias :t :babelize
        alias :_ :babelize

      end
    end
    
    Merb::Controller.send(:include, MLocale)
    Merb::Controller.send(:include, ML10n)
  end
  
  Merb::BootLoader.after_app_loads do
    # code that can be required after the application loads
  end
  
  Merb::Plugins.add_rakefiles "merb_babel/merbtasks"
end
