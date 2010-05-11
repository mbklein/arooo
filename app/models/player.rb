class Player < ActiveRecord::Base
  belongs_to :game
  belongs_to :person
  has_one :died_on, :class_name => 'Day', :primary_key => 'death_day_id'

  def name
    self.person.name
  end

  def nicknames
    self.person.nicknames
  end
  
  def valid_names
    self.person.name
  end
  
  def to_s
    self.person.name
  end
  
  def inspect
    %{\#<#{self.class.name} "#{self.to_s}">}
  end
end
