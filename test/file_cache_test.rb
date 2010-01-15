require 'test_helper'
require 'mocha'

class FileCacheTest < Test::Unit::TestCase
  context "Creating File cache" do
    should "require a location" do
      begin
	cache = Flannel::FileCache.new
	assert_fail "should have raised ArgumentError"
      rescue ArgumentError => e
	assert true
      end
    end
    
    should "require a valid location" do
      begin
	cache = Flannel::FileCache.new "foo/bar"
	assert_fail "should have raised Flannel::CacheLocationDoesNotExistError"
      rescue Flannel::CacheLocationDoesNotExistError => e
	assert true
      end
    end
  end
  
  context "Generating a key" do
    setup do
      @cache = Flannel::FileCache.new "tmp"
    end
    
    should "be private" do
      begin
	key = @cache.generate_key "http://example.com"
	assert_fail "generate_key should be private"
      rescue NoMethodError => e
	assert true
      end
    end
    
    should "make MD5 hash" do
      url = "http://example.com"
      key = @cache.send :generate_key, url
      assert_equal(Digest::MD5.hexdigest(url), key)
    end
  end
  
  context "saving a file" do
    setup do
      clear_dir "tmp"
      @url = "http://example.com"
      @cache_location = "tmp"
      @cache = Flannel::FileCache.new @cache_location
      @key = @cache.send :generate_key, @url
    end
    
    should "save data to a file" do
      @cache.save @url, "some data"
      assert File.exists?(File.join(@cache_location, @key)), "cache did not save data"
    end
  end
  
  context "retrieving data" do
    setup do
      clear_dir "tmp"
      @url = "http://example.com"
      @cache_location = "tmp"
      @data = "this is some data"
      @cache = Flannel::FileCache.new @cache_location
      @key = @cache.send :generate_key, @url
    end
    
    should "should return the saved data" do
      @cache.save @url, @data
      data = @cache.retrieve @url
      assert_equal @data, data
    end
    
    should "should return nil if there is no data" do 
      data = @cache.retrieve @url
      assert_nil data
    end
  end
  
  context "expiration" do
    setup do
      clear_dir "tmp"
      @url = "http://example.com"
      @cache_location = "tmp"
      @data = "this is some data"
    end
    
    should "accept an expiration time" do
      cache = Flannel::FileCache.new @cache_location, 1
      assert_equal 1, cache.seconds_till_expiration
    end
    
    should "default expiration to 1 hour" do
      cache = Flannel::FileCache.new @cache_location
      assert_equal 3600, cache.seconds_till_expiration
    end
    
    should "miss when content is expired" do 
      cache = Flannel::FileCache.new @cache_location, 1
      cache.save @url, @data
      sleep 1
      assert_nil(cache.retrieve(@url))
    end
    
    should "hit when content is not expired" do 
      cache = Flannel::FileCache.new @cache_location, 2
      cache.save @url, @data
      assert_equal(@data, cache.retrieve(@url))
    end
  end
end