class Game < ActiveRecord::Base
  has_many :players, :order => 'seq'
  has_many :days, :order => 'seq'
  belongs_to :moderator, :class_name => 'Person'
  belongs_to :server
  
  def add_player(person)
    player = Player.create(:game => self, :person => person, :seq => self.players.length)
    self.players << player
    player
  end
  
  def find_player(str)
    person = Person.identify(str)
    player = self.players.select { |p| p.person == person }.first
  end
  
end
