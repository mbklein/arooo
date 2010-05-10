class Game < ActiveRecord::Base
  has_many :players, :order => 'seq'
  has_many :days, :order => 'seq'
  belongs_to :moderator, :class_name => 'Person'
  belongs_to :server
  
  def add_players(people, opts = {})
    opts = { :create => false }.merge(opts)
    people.each { |person|
      unless person.is_a?(Person)
        name = person
        person = Person.identify(name, :exact)
        if person.nil? and opts[:create]
          person = Person.create(:name => name)
        end
      end
      player = Player.create(:game => self, :person => person, :seq => self.players.length)
      self.players << player
      player
    }
  end
  
  def find_player(str)
    person = Person.identify(str)
    player = self.players.select { |p| p.person == person }.first
  end
  
end
