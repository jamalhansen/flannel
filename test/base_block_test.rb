require 'test_helper'

class BaseBlockTest < Test::Unit::TestCase
  def test_initializes_with_header_array_and_text
    block = new_block [[[:block_type, :paragraph], [:block_id, "some-id"], [:attribute_list]], "some text"]
    
    assert_equal :paragraph, block.type
    assert_equal "some-id", block.id
    assert_equal "some text", block.text
  end
  
  def test_initializes_with_parent_id
    block = new_block [[[:block_type, :paragraph], [:block_id, "some-id"], [:parent_id, "parent-id"]], "some text"]
    
    assert_equal :paragraph, block.type
    assert_equal "some-id", block.id
    assert_equal "parent-id", block.parent_id
    assert_equal "some text", block.text
  end
  
  def test_initializes_with_attribute_list
    block = new_block [[[:block_type, :paragraph], [:block_id, "some-id"], [:attribute_list, [:class, "cool"]]], "some text"]
    
    assert_equal :paragraph, block.type
    assert_equal "some-id", block.id
    assert_equal "cool", block.attributes[:class]
    assert_equal "some text", block.text
  end
  
  def test_initializes_with_attribute_list_and_parent_id
    block = new_block [[[:block_type, :paragraph], [:block_id, "some-id"], [:parent_id, "parent-id"], [:attribute_list, [:class, "cool"]]], "some text"]
   
    assert_equal :paragraph, block.type
    assert_equal "some-id", block.id
    assert_equal "parent-id", block.parent_id
    assert_equal "cool", block.attributes[:class]
    assert_equal "some text", block.text
  end
  
  def test_initializes_with_header_array_and_no_text
    block = new_block [[[:block_type, :paragraph], [:block_id, "some-id"]]]
    
    assert_equal :paragraph, block.type
    assert_equal "some-id", block.id
    assert_nil block.text, "Block#text should be nil"
  end
  
  def test_initialized_from_parser_output
    text = ":preformatted my-code great-code class=ruby whiz=bang\ndef foo arg\n\t puts arg\n end"
    doc = BlockParser.new.parse(text)
    block = Flannel::BaseBlock.new doc.content[0]
   
    assert_equal :preformatted, block.type
    assert_equal "my-code", block.id
    assert_equal "great-code", block.parent_id
    assert_equal "ruby", block.attributes[:class]
    assert_equal "bang", block.attributes[:whiz]
    assert_equal "def foo arg\n\t puts arg\n end", block.text
  end
end