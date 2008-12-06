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

    # def page_nav_links(format = 'markdown')
    #   return unless params[:action] == 'show' # Don't need navigation for the TOC (index).
    #   chapter_name = params[:chapter]
    #   page_name    = params[:page_name]
    #   dir_match    = "#{Merb.root}/book-content/#{language}/*-#{chapter_name}/*-#{page_name||"*"}.#{format}"
    #   current_file = Dir[dir_match].entries.first
    #   chapter_and_page_regexp = /book-content\/\w{2}\/(\d{1,})-[a-z-]+\/(\d{1,})-[a-z-]+[.]\w+/
    #   current_file.grep(chapter_and_page_regexp)
    #   chapter_num = $1
    #   page_num    = $2
    #   links = next_page(page_num, chapter_num, format)
    #   links
    # end

    def page_nav_links(format = 'markdown')
      return unless params[:action] == 'show' # Don't need navigation for the TOC (index).
      chapter = params[:chapter]
      page_name = params[:page_name]
      current_file = Dir["#{Merb.root}/book-content/#{language}/*-#{chapter}/*-#{page_name||"*"}.#{format}"].entries.first
      current_file.grep(/book-content\/\w{2}\/(\d{1,})-[a-z-]+\/(\d{1,})-[a-z-]+[.]\w+/)
      chapter_number, page_number = $1, $2
      next_file = Dir["#{Merb.root}/book-content/#{language}/#{chapter_number}-*/#{page_number.to_i + 1}-*.#{format}"].entries.first
      if next_file
        next_file.grep(chapter_and_page_names)
      else
        # We're on the last page, get the first page of the next chapter.
        next_file = Dir["#{Merb.root}/book-content/#{language}/#{chapter_number.to_i + 1}-*/**"].entries.first
        next_file.grep(chapter_and_page_names)
      end
      chapter_name, page_name = $1, $2
      next_page(chapter_name, page_name)
    end

    private

    def next_page(chapter_name, page_name)
      link_to('Next', url(:page, :language => language, :chapter => chapter_name, :page_name => page_name))
    end

    # This method returns a Regexp which contains match captures for the chapter and page names.
    def chapter_and_page_names
      /book-content\/\w{2}\/\d{1,}-([a-z-]+)\/\d{1,}-([a-z-]+)[.]\w+/
    end

  end
end
