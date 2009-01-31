module Merb
  module GlobalHelpers
    # helpers defined here available to all views.

    def same_url_but_in_english
      named_route = params[:chapter] ? :page : :toc
      url(named_route, :language => 'en', :chapter => params[:chapter], :page_name => params[:page_name])
    end

    def language_switch
      Merb::Plugins.config[:Merb_babel][:available_languages].map do |lang|
        href = "/#{lang[:code]}"
        href += "/#{params[:chapter]}" if params[:chapter]
        href += "/#{params[:page_name]}" if params[:page_name]
        "<a href='#{href}'>#{lang[:name]}</a>" unless lang[:code] == language
      end.compact.join(" | ")
    end
    
    def rtl_support_class
      "class='rtl'" if ['ar', 'ur', 'he'].include?(language)
    end

    # Returns links to the previous and next pages.
    def page_nav_links(format = 'markdown')
      return if params[:action] != 'show' || @page.nil? # Don't need navigation for the TOC (index).
      links = []
      links << previous_page_url unless @page.previous_file.include?('table-of-contents')
      # Stick a link to the TOC in the middle of the array.
      links << link_to(language_text(language, 'Home'), url(:toc, :language => language))
      links << next_page_url unless @page.next_file.include?('table-of-contents')
      links.join(' | ')
    end
    
    # returns the table of contents link
    def toc_link
      return unless action_name == 'show' # Don't need navigation for the TOC (index).
      link_to(language_text(language, 'Table of Contents'), url(:toc, :language => language))
    end
    
    def next_page_url
      link_to(language_text(language, 'Next'), url(:page, :language => language, :chapter => @page.next_chapter_name, :page_name => @page.next_page_name))
    end

    def previous_page_url
      link_to(language_text(language, 'Previous'), url(:page, :language => language, :chapter => @page.previous_chapter_name, :page_name => @page.previous_page_name))
    end

    private
    # returns the translated text based on the current language
    def language_text(language_code, text)
      result = text
      Merb::Plugins.config[:Merb_babel][:available_languages].map do |lang|
        result = lang[text.gsub(' ', '_').downcase.to_sym] if lang[:code] == language_code
      end
      result ||= text
    end

  end
end
