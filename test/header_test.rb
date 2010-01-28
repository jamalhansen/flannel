require 'test_helper'

class HeaderTest < Test::Unit::TestCase
  context "basic properties" do
    setup do
      @header = Flannel::Header.new "    My Header"
    end
    
    should "have text of My Header" do
      assert_equal "My Header", @header.text
    end
    
    should "have identity of :my_header" do
      assert_equal :my_header, @header.identity
    end
    
    should "have level of 2" do
      assert_equal 2, @header.level
    end
  end
  
  context "tabbed indented header" do
    setup do
      @header = Flannel::Header.new "\t\tMy Header"
    end
    
    should "have text of My Header" do
      assert_equal "My Header", @header.text
    end
    
    should "have identity of :my_header" do
      assert_equal :my_header, @header.identity
    end
    
    should "have level of 2" do
      assert_equal 2, @header.level
    end
  end
end