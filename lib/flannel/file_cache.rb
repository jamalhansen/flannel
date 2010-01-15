require 'flannel/cache_location_does_not_exist_error'
require 'digest/md5'

module Flannel
  class FileCache
    attr_reader :seconds_till_expiration
    
    def initialize cache_location, seconds_till_expiration=3600
      unless File.exists?(cache_location) && File.directory?(cache_location)
	raise CacheLocationDoesNotExistError
      end
      
      @cache_location = cache_location
      @seconds_till_expiration = seconds_till_expiration
    end
    
    def save url, data
      key = generate_key url
      File.open(File.join(@cache_location, key), 'w') {|f| f.write(data) }
    end
    
    def retrieve url
      key = generate_key url
      file = File.join(@cache_location, key)
      
      return nil unless File.exists?(file)
	    
      saved_at = File.mtime(file)
      expires_at = saved_at + @seconds_till_expiration
      
      if Time.now >= expires_at
	File.delete(file)
	return nil
      end
      
      read file     
    end
    
    private
      def generate_key url
	Digest::MD5.hexdigest(url)
      end
   
      def read file
	data = ''
	File.open(file, "r") { |f|
	    data = f.read
	}
	data
      end
  end
end
