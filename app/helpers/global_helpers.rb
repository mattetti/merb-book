module Merb
  module GlobalHelpers
    # helpers defined here available to all views.  
    
    def same_url_but_in_english
      named_route = params[:chapter] ? :page : :toc
      url(named_route, :language => 'en', :chapter => params[:chapter], :page_name => params[:page_name])
    end
    
    def language_switch
      Merb::Plugins.config[:Merb_babel][:available_languages].map do |lang|
        "<a href='/#{lang[:code]}'>#{lang[:name]}</a>" unless lang[:code] == language
      end.compact.join(" | ")
    end
    
  end
end
