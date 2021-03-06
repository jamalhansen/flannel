require 'test_helper'
require 'pp'

class BlockParserTest < Test::Unit::TestCase
  def setup
    @parser = BlockParser.new
  end

  def test_parser_returns_empty_array_for_empty_string
    assert_equal 0, @parser.parse("").content.length, "Parser was expected to return no elements for an empty string"
  end
  
  def test_parser_returns_text_it_does_not_recognize
    assert_equal [[:plain_text, "yadda foo bar === :cheese"]], @parser.parse("yadda foo bar === :cheese").content, "Parser was expected to return non flannel text"
  end
  
  def test_parser_returns_text_it_does_not_recognize_and_flannel
    expected = [[:plain_text, "yadda foo bar === cheese"], [:block, [[[:block_type, :paragraph], [:attribute_list]], " foo"]]]
    
    assert_equal expected, @parser.parse("yadda foo bar === cheese\n:paragraph: foo").content, "Parser was expected to return non flannel text"
  end
  
  def test_parser_returns_simple_block
    doc = @parser.parse(":paragraph wonki:text")
    
    assert_doc doc, :paragraph, "wonki", "text"
  end
  
  def test_colon_will_end_header
    doc = @parser.parse(":paragraph wonki:text")
    
    assert_doc doc, :paragraph, "wonki", "text"
  end
  
  def test_will_allow_whitespace_before_colon
    doc = @parser.parse(":paragraph wonki    :text")
    
    assert_doc doc, :paragraph, "wonki", "text"
  end
  
  def test_parser_returns_simple_block_without_id
    doc = @parser.parse(":paragraph:\ntext")
    
    assert_doc doc, :paragraph, nil, "text"
  end
  
  def test_parser_returns_block_with_dashed_block_id
    doc = @parser.parse(":paragraph wonki-donki:\ntext")

    assert_doc doc, :paragraph, "wonki-donki", "text"
  end
  
  def test_parser_returns_block_with_parent_id
    doc = @parser.parse(":paragraph wonki-donki parent_id:\ntext")

    assert_doc doc, :paragraph, "wonki-donki", "text", "parent_id"
  end
  
  def test_parser_returns_block_with_parent_id_and_attributes
    doc = @parser.parse(":paragraph wonki-donki parent_id class=foo title=monkey:\ntext")

    assert_doc doc, :paragraph, "wonki-donki", "text", "parent_id", { :class => "foo", :title => "monkey" }
  end
  
  def test_parser_returns_two_simple_blocks
    doc = @parser.parse(":paragraph foo:bar\n:paragraph baz:bonzo")

    assert_not_nil doc
    
    blocks = doc.content
    
    assert_block blocks[0][1], :paragraph, "foo", "bar\n"
    assert_block blocks[1][1], :paragraph, "baz", "bonzo"
  end
end