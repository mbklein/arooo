class Vote < ActiveRecord::Base
  belongs_to :day
  belongs_to :voter,  :class_name => 'Player'
  belongs_to :target, :class_name => 'Player'
  
  def action
    self.target_name.nil? ? 'unvote' : 'vote'
  end
  
  def identified
    identified = (action == 'unvote' || (self.target_name && self.target_id)) ? true : false
  end
  
  def resolve(target, global = true)
    self.update_attribute :target, target
    if global
      target.person.nicknames << Nickname.create(:nickname => self.target_name)
      self.class.find(:all, :conditions => ['target_id IS NULL AND UPPER(target_name) = ?', self.target_name.upcase]).each { |v|
        v.resolve(target, false)
      }
    end
  end
  
  def self.resolve
    self.find(:all, :conditions => ['target_id IS NULL AND UPPER(target_name) IS NOT NULL']).each { |v|
      target = v.day.game.find_player(v.target_name)
      unless target.nil?
        v.resolve(target, false)
      end
    }
  end
  
  def to_s
    str = "%s: %s %s" % [self.voter.person.name, self.action, self.target ? self.target.person.name : (self.target_name ? "#{self.target_name} (*)" : "")]
  end
end
