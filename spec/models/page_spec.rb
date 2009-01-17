require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "Page" do
  
  before(:each) do
    @page = Page.new(:name => "preface", :chapter => "front-matter")
  end
  
  it "should have a filename" do
    @page.file.should_not be_nil
    @page.file.should include("book-content/en/0-front-matter/1-preface.markdown")
  end
  
  it "should have a html version" do
    @page.to_html.should include("<h1 id='preface'>Preface</h1>")
  end

  it "should have a previous file" do
    @page.previous_file.should_not be_nil
    @page.previous_file.should include("book-content/en/0-front-matter/0-")
  end
  
  it "should know the previous chapter name" do
    @page.previous_chapter_name.should_not be_nil
  end
  
  it "should know the previous page name" do
    @page.previous_page_name.should_not be_nil
  end
  
  it "should have a next file" do
    @page.next_file.should_not be_nil
    @page.next_file.should include("book-content/en/0-front-matter/2-")
  end
  
  it "should know the next chapter name" do
    @page.next_chapter_name.should_not be_nil
  end
  
  it "should know the next page name" do
    @page.next_page_name.should_not be_nil
  end
  
end