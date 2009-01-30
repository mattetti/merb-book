class Pages < Application

  def index
    table_of_content
  end
  
  def show
    @page = Page.new( :name     => params[:page_name],
                      :chapter  => params[:chapter],
                      :language => language)
    raise NotFound unless @page.file
    render @page.to_html
  end
  
  def table_of_content
    toc_file = Dir["#{Merb.root}/book-content/#{language}/toc.*"].entries.first
    raise NotFound unless toc_file
    text = File.open(toc_file).read
    render ::Maruku::new(text).to_html
  end
  
end
