class Pages < Application

  def index
    render
  end
  
  def show
    chapter   = params[:chapter]
    page_name = params[:page_name]
    
    page_file = find_page_file(chapter, page_name)
    raise NotFound unless page_file    
    
    text = File.open(page_file).read
    render Maruku::new(text).to_html
  end
  
  private
    # If no page name is being passed, the first page is being returned
    def find_page_file(chapter, page_name, format="markdown")
      Dir["#{Merb.root}/book-content/*-#{chapter}/*-#{page_name||"*"}.#{format}"].entries.first
    end
  
end
