require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "Pages controller" do

  it 'should return 404' do
    @response = request(url(:page, :chapter => 'non-existing-chapter'))
    @response.status.should == 404
  end

  describe 'default language' do
    before(:each) do
      @response = request('/')
    end

    it 'should be successful' do
      @response.should be_successful
    end
  end

  describe 'english' do
    describe 'table of contents' do
      before(:each) do
        @response = request(url(:toc, :language => 'en'))
      end

      it 'should be successful' do
        @response.should be_successful
      end
    end

    describe 'chapters' do
      it 'should find Front Matter' do
        @response = request_chapter('front-matter')
        @response.should be_successful
      end

      it 'should find Introduction' do
        @response = request_chapter('introduction')
        @response.should be_successful
      end

      it 'should find Getting Started' do
        @response = request_chapter('getting-started')
        @response.should be_successful
      end

      it 'should find Interacting with the Database' do
        @response = request_chapter('interacting-with-the-database')
        @response.should be_successful
      end

      it 'should find Testing Your Application' do
        @response = request_chapter('testing-your-application')
        @response.should be_successful
      end

      it 'should find Merb More' do
        @response = request_chapter('merb-more')
        @response.should be_successful
      end

      it 'should find Recipes' do
        @response = request_chapter('recipes')
        @response.should be_successful
      end

      it 'should find Deployment' do
        @response = request_chapter('deployment')
        @response.should be_successful
      end

      it 'should find Appendix' do
        @response = request_chapter('appendix')
        @response.should be_successful
      end
    end
  end
end

private

def request_chapter(chapter)
  request(url(:page, :chapter => chapter))
end
