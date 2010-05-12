class ActiveRecord::Base

  class << self
    def match_attributes(params)
      result = {}
      params.each_pair { |k,v|
        result[k] = v if self.column_names.include?(k.to_s)
      }
      return result
    end
  end
  
  def match_attributes(params)
    self.class.match_attributes(params)
  end
  
end