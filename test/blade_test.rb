require 'test_helper'
require 'flannel/document'

class BladeTest < Test::Unit::TestCase
  context "cutting a simple file" do
    setup do
      @text = IO.read(File.join(File.dirname(__FILE__), 'fixtures', 'simple.flannel'))
      @blade = Flannel::Blade.new
    end

    should "have a simple flannel example" do
      assert_not_nil @text
    end
    
    should "return a document" do
      document = @blade.cut @text
      
      assert_equal Flannel::Document, document.class
      assert_not_nil document.content
    end
  end
end