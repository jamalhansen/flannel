$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'flannel'

require 'test/unit/assertions'

World(Test::Unit::Assertions)
