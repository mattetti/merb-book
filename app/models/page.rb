class Page
  
  attr_accessor :file, :name, :chapter, :language
  attr_reader   :chapter_number, :page_number, :next_file, :previous_file
  attr_reader   :previous_file, :next_file
  
  def initialize(args={})
    @name      = args[:name]
    @chapter   = args[:chapter]
    @language  = args[:language] || 'en'
  end
  
  def file
    @file ||= find_page_file
  end
  
  def text
    @text ||= File.open(file).read
  end
  
  def to_html
    @html ||= ::Maruku::new(text).to_html
  end
  
  def chapter_number
    return @chapter_number unless @chapter_number.nil?
    extract_chapter_and_page_number
    @chapter_number
  end
  
  def page_number
    return @page_number unless @page_number.nil?
    extract_chapter_and_page_number
    @page_number
  end
  
  def next_file
    return @next_file unless @next_file.nil?
    n_file = Dir["#{Merb.root}/book-content/#{language}/#{chapter_number}-*/#{page_number + 1}-*.*"].entries.first
    if n_file.nil?
      n_file = Dir["#{Merb.root}/book-content/#{language}/#{chapter_number + 1}-*/toc.*"].entries.first
      # We're on the last page of the last chapter, just return the TOC.
      n_file =  "#{Merb.root}/book-content/#{language}/table-of-contents" if n_file.nil? 
    end
    @next_file = n_file
  end
  
  def next_chapter_name
    return @next_chapter_name unless @next_chapter_name.nil?
    extract_next_chapter_and_page_name
    @next_chapter_name
  end
  
  def next_page_name
    return @next_page_name unless @next_page_name.nil?
    extract_next_chapter_and_page_name
    @next_page_name
  end
  
  def previous_file
    return @previous_file unless @previous_file.nil?
    p_file = Dir["#{Merb.root}/book-content/#{language}/#{chapter_number}-*/#{page_number - 1}-*.*"].entries.first
    if p_file.nil?
      p_file = Dir["#{Merb.root}/book-content/#{language}/#{chapter_number - 1}-*/[0-9]*?*.*"].entries.last
      p_file = Dir["#{Merb.root}/book-content/#{language}/#{chapter_number - 1}-*/toc.*"].entries.first if p_file.nil?
      # We're on the last page of the last chapter, just return the TOC.
      p_file =  "#{Merb.root}/book-content/#{language}/table-of-contents" if p_file.nil? 
    end
    @previous_file = p_file
  end
  
  def previous_chapter_name
    return @previous_chapter_name unless @previous_chapter_name.nil?
    extract_previous_chapter_and_page_name
    @previous_chapter_name
  end
  
  def previous_page_name
    return @previous_page_name unless @previous_page_name.nil?
    extract_previous_chapter_and_page_name
    @previous_page_name
  end
  
  private
    def find_page_file
      base = "#{Merb.root}/book-content/#{language}/*-#{chapter}"
      if name
        Dir["#{base}/*-#{name}.*"].entries.first
      else
        Dir["#{base}/toc.*"].entries.first
      end
    end
    
    def extract_chapter_and_page_number
      file =~ /book-content\/\w{2}\/(\d{1,})-[a-z-]+\/((\d{1,})-[a-z-]+|toc)[.]\w+/
      @chapter_number, @page_number = $1.to_i, $3.to_i
    end
    
    def extract_next_chapter_and_page_name
      @next_chapter_name, @next_page_name = extract_chapter_and_page_number_for_file(next_file)
    end
    
    def extract_previous_chapter_and_page_name
      @previous_chapter_name, @previous_page_name = extract_chapter_and_page_number_for_file(previous_file)
    end
    
    # Returns an array with the chapter name and the page name of the file to process
    def extract_chapter_and_page_number_for_file(file_to_process)
        file_to_process.grep(/book-content\/\w{2}\/\d{1,}-([a-z-]+)\/(\d{1,}-([a-z-]+)|(toc))[.]\w+/)
        [$1, $3]
    end
  
end