require 'test_helper'

class HeaderTest < Test::Unit::TestCase
  context "basic properties" do
    setup do
      @header = Flannel::Header.new "My Header"
    end
    
    should "have text of My Header" do
      assert_equal "My Header", @header.text
    end
    
    should "have identity of :my_header" do
      assert_equal :my_header, @header.identity
    end
    
    should "have level of 1" do
      assert_equal 1, @header.level
    end
  end
  
  context "space indented header" do
    setup do
      @header = Flannel::Header.new "    My Header"
    end
    
    should "have text of My Header" do
      assert_equal "My Header", @header.text
    end
    
    should "have identity of :my_header" do
      assert_equal :my_header, @header.identity
    end
    
    should "have level of 3" do
      assert_equal 3, @header.level
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
    
    should "have level of 3" do
      assert_equal 3, @header.level
    end
  end
  
  context "identity" do
    should "be created from the text" do
      header = Flannel::Header.new "My Header"
      assert_equal :my_header, header.identity
    end
    
    should "remove non-standard characters" do
      header = Flannel::Header.new "My !@%^&* Kick*** Header"
      assert_equal :my_kick_header, header.identity
    end
    
    should "be overridden by # syntax" do
      header = Flannel::Header.new "My Header#your header"
      assert_equal :your_header, header.identity
    end
  end
  
  should "not have a level > 6" do
    header = Flannel::Header.new "\t\t\t\t\t\t\t\t\t\t\t\tMy Header"
    assert_equal 6, header.level
  end
end