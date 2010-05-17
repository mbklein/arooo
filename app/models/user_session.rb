class UserSession < Authlogic::Session::Base

  class << self
    def find(*args)
      begin
        super(*args) || ANONYMOUS_USER_SESSION
      rescue
        ANONYMOUS_USER_SESSION
      end
    end
  end

  def rights(game = nil)
    if game.nil?
      Access.find_all_by_user_id(self.user.id)
    else
      g = if game.is_a?(Integer)
        Game.find(game)
      elsif game.is_a?(String)
        Game.find_by_name(game)
      else
        game
      end

      if g.is_a?(Game)
        g.accesses.find_by_user_id(self.user.id)
      else 
        raise ArgumentError, "Unknown Game: #{game}"
      end
    end
  end

  def can_moderate?(game)
    rights(game).can_moderate?
  end

  def can_observe?(game)
    game.over || rights(game).can_observe?
  end

  def can_view?(game)
    game.over || rights(game).can_view?
  end

end

ANONYMOUS_USER_SESSION = UserSession.new

class << ANONYMOUS_USER_SESSION
  
  def user
    nil
  end
  
  def save
    true
  end
  
  def can_moderate?(game)
    false
  end

  def can_observe?(game)
    game.over
  end

  def can_view?(game)
    game.over || game.allow_anonymous_view
  end
  
end