require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'fileutils'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'flannel'

class Test::Unit::TestCase
  def assert_fail message
    assert false, message
  end
  
  def new_block list
    Flannel::BaseBlock.new [ :block, list ]
  end
  
  def clear_dir dirname
    Dir.foreach(dirname) do |f|
      path = File.join(dirname, f)
      if f == '.' or f == '..' then 
        next
      elsif 
        File.directory?(path) then FileUtils.rm_rf(path)
      else 
        FileUtils.rm( path )
      end
    end
  end
  
  def assert_doc doc, expected_type, expected_id, expected_text, expected_parent_id=nil, expected_attributes=nil
    assert_not_nil doc
    
    item = doc.content[0]
    assert_equal :block, item[0]
    
    block = item[1]
    
    assert_block block, expected_type, expected_id, expected_text, expected_parent_id, expected_attributes
  end
  
  def assert_block block, expected_type, expected_id, expected_text, expected_parent_id=nil, expected_attributes=nil
    header = block.shift
    
    type = header.shift
    assert_equal 2, type.length
    assert_equal :block_type, type[0]
    assert_equal expected_type, type[1]   
    
    if expected_id
      id = header.shift
      assert_equal 2, id.length
      assert_equal :block_id, id[0]
      assert_equal expected_id, id[1] 
    end
    
    if expected_parent_id
      parent_id = header.shift
      assert_equal 2, parent_id.length
      assert_equal :parent_id, parent_id[0]
      assert_equal expected_parent_id, parent_id[1] 
    end
    
    attribute_list = header.shift
    assert_equal :attribute_list, attribute_list[0]
    
    if expected_attributes
      attributes = attribute_list.dup
      attributes.shift

      assert_equal expected_attributes.length, attributes.length
      attributes.each do |attribute|
        assert_equal expected_attributes[attribute[0]], attribute[1]
      end
    else
      assert_equal 1, attribute_list.length
    end
       
    assert_equal expected_text, block.shift
  end
end
