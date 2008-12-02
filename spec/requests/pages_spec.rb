require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/pages" do
  before(:each) do
    @response = request("/pages")
  end
end