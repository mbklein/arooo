class Game < ActiveRecord::Base
  has_many :players, :order => 'seq', :dependent => :destroy
  has_many :days, :order => 'seq', :dependent => :destroy
  belongs_to :moderator, :class_name => 'Person'
  belongs_to :server

  TRANSFORMATIONS = [/^(.+)$/,/^([A-Za-z0-9_-]+).*$/,/^(.+) harder.*$/,/^(\S+).*$/]
  
  def new_day(topic_id = nil)
    self.days << Day.create(:seq => self.days.length+1, :topic_id => topic_id)
  end
  
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
      player = Player.create(:game => self, :person => person, :seq => self.players.length+1)
      self.players << player
      player
    }
  end
  
  def find_player(p)
    if p.is_a?(Player)
      person = p.person
    elsif p.is_a?(Person)
      person = p
    else
      TRANSFORMATIONS.each { |re|
        p_name = p.scan(re).flatten.first
        person = Person.identify(p_name, :exact) unless p_name.nil?
        break unless person.nil?
      }
    end

    return self.players.select { |player| player.person == person }.first
  end
  
end
