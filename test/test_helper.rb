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
end
