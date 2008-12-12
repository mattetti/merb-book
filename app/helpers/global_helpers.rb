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
      return if params[:action] != 'show' # Don't need navigation for the TOC (index).
      links = []
      @current_file =~ /book-content\/\w{2}\/(\d{1,})-[a-z-]+\/(\d{1,})-[a-z-]+[.]\w+/
      chapter_number, page_number = $1, $2

      chapter_name, page_name = extract_previous_page(chapter_number, page_number)
      links << previous_page(chapter_name, page_name)

      # Stick a link to the TOC in the middle of the array.
      links << link_to(language_text(language, 'Home'), url(:toc, :language => language))

      chapter_name, page_name = extract_next_page(chapter_number, page_number)
      links << next_page(chapter_name, page_name)

      links.join(' | ')
    end
    
    # returns the table of contents link
    def toc_link
      return unless params[:action] == 'show' # Don't need navigation for the TOC (index).
      link_to(language_text(language, 'Table of Contents'), url(:toc, :language => language))
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

    def next_page(chapter_name, page_name)
      link_to(language_text(language, 'Next'), url(:page, :language => language, :chapter => chapter_name, :page_name => page_name))
    end

    def previous_page(chapter_name, page_name)
      link_to(language_text(language, 'Previous'), url(:page, :language => language, :chapter => chapter_name, :page_name => page_name))
    end

    # This method returns a Regexp which contains match captures for the chapter and page names.
    def chapter_and_page_names
      /book-content\/\w{2}\/\d{1,}-([a-z-]+)\/\d{1,}-([a-z-]+)[.]\w+/
    end

    # Returns an array of the next chapter and page names.
    def extract_next_page(chapter_number, page_number, format = 'markdown')
      next_file = Dir["#{Merb.root}/book-content/#{language}/#{chapter_number}-*/#{page_number.to_i + 1}-*.#{format}"].entries.first
      if next_file
        next_file.grep(chapter_and_page_names)
      else
        # We're on the last page, get the first page of the next chapter.
        next_file = Dir["#{Merb.root}/book-content/#{language}/#{chapter_number.to_i + 1}-*/**"].entries.first
        if next_file
          next_file.grep(chapter_and_page_names)
        else
          # We're on the last page of the last chapter, just return the TOC.
          return 'table-of-contents'
        end
      end
      chapter_name, page_name = $1, $2
      [chapter_name, page_name]
    end

    # Returns an array of the previous chapter and page names.
    def extract_previous_page(chapter_number, page_number, format = 'markdown')
      next_file = Dir["#{Merb.root}/book-content/#{language}/#{chapter_number}-*/#{page_number.to_i - 1}-*.#{format}"].entries.first
      if next_file
        next_file.grep(chapter_and_page_names)
      else
        # We're on the first page, get the last page of the previous chapter.
        next_file = Dir["#{Merb.root}/book-content/#{language}/#{chapter_number.to_i - 1}-*/**"].entries.last
        if next_file
          next_file.grep(chapter_and_page_names)
        else
          # We're on the first page of the first chapter, just return the TOC.
          return 'table-of-contents'
        end
      end
      chapter_name, page_name = $1, $2
      [chapter_name, page_name]
    end

  end
end
