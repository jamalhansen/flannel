module Flannel
  class Header
    attr_reader :nodes, :text, :identity, :level
    
    def initialize text
      parse text
      @nodes = []
    end
    
    def add_node node
      @nodes << node
    end 
    
    def parse text
      # need to check for leading whitespace
      leader, text = split_leader text

      @level = calculate_level leader
      get_attributes text
    end
    
    def split_leader text
      return [nil, text] unless " \t".include? text[0]
      text.split(/(?=\w)/, 2)
    end
    
    def get_attributes text
      @text, identity = text.split(/\#/, 2)

      @identity ||= symbolize( identity ? identity : @text)
    end
      
    def symbolize text
      text.gsub(%r{[^\w\s\_]},'').gsub(%r{[^\w]},' ').split.join('_').downcase.to_sym
    end
    
    def calculate_level leader
      return 1 unless leader
      
      tabs = leader.length - leader.gsub(/\t/, "").length
      
      level = (((leader.length - tabs) / 2) + tabs) + 1  # tabs count for 2 spaces, starting at 1 max 6  
      level = 1 if level < 1
      level = 6 if level > 6
      level
    end
  end
end