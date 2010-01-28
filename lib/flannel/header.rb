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
      leader, @text = split_leader text
      
      @level = calculate_level leader
      @identity = @text.gsub(%r{[^\w\s\_]},'').gsub(%r{[^\w]},' ').split.join('_').downcase.to_sym
    end
    
    def split_leader text
      return [nil, text] unless " \t".include? text[0]
      text.split(/(?=\w)/, 2)
    end
    
    def calculate_level leader
      return 0 unless leader
      
      tabs = leader.length - leader.gsub(/\t/, "").length
      ((leader.length - tabs) / 2) + tabs  # tabs count for 2 spaces    
    end
  end
end