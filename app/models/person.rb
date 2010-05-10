class Person < ActiveRecord::Base
  has_many :nicknames
  has_many :moderated_games, :class_name => 'Game', :foreign_key => 'moderator_id'
  has_many :games, :through => :players

  def self.identify(str, match = :fuzzy)
    ci_str = str.upcase
    
    # First look for an exact match
    result = self.find(:first, :conditions => ["UPPER(name) = ?", ci_str])
    if result
      return result
    end
    
    # Then look for an exact nickname match
    found_nick = Nickname.find(:first, :conditions => ["UPPER(nickname) = ?", ci_str])
    if found_nick
      return found_nick.person
    end
    
    if match == :fuzzy
      # Then return an array of partials
      result = self.find(:all, :conditions => ["UPPER(name) LIKE ?", "#{ci_str}%"])
      if result
        return result
      end
    
      result = self.find(:all, :conditions => ["UPPER(nickname) LIKE ?", "#{ci_str}%"]).collect { |found_nick| found_nick.person }
      return result
    end
    
    return nil
  end
  
  def valid_names
    [self.name] + self.nicknames.collect { |nick| nick.nickname }
  end
end
