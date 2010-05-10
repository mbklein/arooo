class Player < ActiveRecord::Base
  belongs_to :game
  belongs_to :person
  has_one :died_on, :class_name => 'Day', :primary_key => 'death_day_id'

  def to_s
    self.person.name
  end
  
  def inspect
    %{\#<Player "#{self.to_s}">}
  end
  
  def method_missing(sym, *args)
    if self.person.respond_to?(sym)
      self.person.send(sym, *args)
    else
      super(sym, *args)
    end
  end
end
