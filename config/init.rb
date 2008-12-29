# Go to http://wiki.merbivore.com/pages/init-rb
 
# Specify a specific version of a dependency
# dependency "RedCloth", "> 3.0"

dependency "maruku", ">= 0.5.9"
dependency "merb-assets", "~> 1.0"
dependency "merb_babel", ">= 0.1.0"


#  use_orm :none
use_test :rspec
use_template_engine :erb
 
Merb::Config.use do |c|
  c[:use_mutex] = false
  c[:session_store] = 'cookie'  # can also be 'memory', 'memcache', 'container', 'datamapper
  
  # cookie session store configuration
  c[:session_secret_key]  = '8cea7e76dcb6c428521f22c4943b4e69430a85fa'  # required for cookie session store
  c[:session_id_key] = '_merb-book_session_id' # cookie session id key, defaults to "_session_id"
end
 
Merb::BootLoader.before_app_loads do
  # This will get executed after dependencies have been loaded but before your app's classes have loaded.
   Merb::Plugins.config[:Merb_babel] = { 
     :default_language    => 'en',
     :available_languages => [
            {:name => "English",    :code => 'en'}, 
            {:name => "Français",   :code => 'fr'},
            {:name => "한국어",        :code => 'kr'},              
            {:name => "日本語",        :code => 'jp'}, 
            {:name => "Português",  :code => 'pt'},
            {:name => "Deutsch",    :code => 'de'},
            {:name => "中文",       :code => 'zh', :home => '首页', :next => '下一页', :previous => '前一页', :table_of_contents => '目录'},
            {:name => "Español",    :code => "es"},
            {:name => "Русский",    :code => 'ru'},
            {:name => "Bosanski",   :code => "bs"},
            {:name => "Nederlands", :code => "nl"},
            {:name => "العربية",    :code => "ar"},
            {:name => "Български",  :code => "bg"},
            {:name => "Italiano",   :code => "it"}
          ]
     }
   
end
 
Merb::BootLoader.after_app_loads do
  # This will get executed after your app's classes have been loaded.
  require 'maruku/ext/div'
end
