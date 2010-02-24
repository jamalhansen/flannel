require 'test_helper'

class BlockParserStylesTest < Test::Unit::TestCase
  def setup
    @parser = BlockParser.new
  end
  
  def test_paragraph
    doc = @parser.parse(":paragraph\ntext")
    
    assert_doc doc, :paragraph, nil, "text"
  end
  
  def test_list
    doc = @parser.parse(":list\ntext")
    
    assert_doc doc, :list, nil, "text"
  end
  
  def test_feed
    doc = @parser.parse(":feed\ntext")
    
    assert_doc doc, :feed, nil, "text"
  end
  
  def test_blockquote
    doc = @parser.parse(":blockquote\ntext")
    
    assert_doc doc, :blockquote, nil, "text"
  end
  
  def test_preformatted
    doc = @parser.parse(":preformatted\ntext")
    
    assert_doc doc, :preformatted, nil, "text"
  end
  
  def test_header_one
    doc = @parser.parse(":header_one\ntext")
    
    assert_doc doc, :header_one, nil, "text"
  end
  
  def test_header_two
    doc = @parser.parse(":header_two\ntext")
    
    assert_doc doc, :header_two, nil, "text"
  end
  
  def test_header_three
    doc = @parser.parse(":header_three\ntext")
    
    assert_doc doc, :header_three, nil, "text"
  end
  
  def test_header_four
    doc = @parser.parse(":header_four\ntext")
    
    assert_doc doc, :header_four, nil, "text"
  end
  
  def test_header_five
    doc = @parser.parse(":header_five\ntext")
    
    assert_doc doc, :header_five, nil, "text"
  end
  
  def test_header_six
    doc = @parser.parse(":header_six\ntext")
    
    assert_doc doc, :header_six, nil, "text"
  end
  
end

