class Pages < Application

  def index
    @page_file = find_toc
    raise NotFound unless @page_file    
    
    text = File.open(@page_file).read
    render Maruku::new(text).to_html
  end
  
  def show
    @page = Page.new( :name     => params[:page_name],
                      :chapter  => params[:chapter],
                      :language => language)
    raise NotFound unless @page.file
    render @page.to_html
  end
  
  private
    
    def find_toc(format="markdown")
      Dir["#{Merb.root}/book-content/#{language}/toc.#{format}"].entries.first
    end
  
end
