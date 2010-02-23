require 'test_helper'
require 'pp'

class BlockParserTest < Test::Unit::TestCase
  def setup
    @parser = BlockParser.new
  end

  def test_parser_returns_empty_array_for_empty_string
    assert_equal 0, @parser.parse("").content.length, "Parser was expected to return no elements for an empty string"
  end
  
  def test_parser_returns_simple_block
    doc = @parser.parse(":paragraph wonki\ntext")
    
    assert_doc doc, :paragraph, "wonki", "text"
  end
  
  def test_parser_returns_block_with_dashed_block_id
    doc = @parser.parse(":paragraph wonki-donki\ntext")

    assert_doc doc, :paragraph, "wonki-donki", "text"
  end
  
  def test_parser_returns_block_with_parent_id
    doc = @parser.parse(":paragraph wonki-donki parent_id\ntext")

    assert_doc doc, :paragraph, "wonki-donki", "text", "parent_id"
  end
  
  def test_parser_returns_block_with_parent_id_and_attributes
    doc = @parser.parse(":paragraph wonki-donki parent_id class=foo title=monkey\ntext")

    assert_doc doc, :paragraph, "wonki-donki", "text", "parent_id", { :class => "foo", :title => "monkey" }
  end
  
  def test_parser_returns_two_simple_blocks
    doc = @parser.parse(":paragraph foo\nbar\n:paragraph baz\nbonzo")

    assert_not_nil doc
    
    blocks = doc.content
    
    assert_block blocks[0], :paragraph, "foo", "bar"
    assert_block blocks[1], :paragraph, "baz", "bonzo"
  end
end