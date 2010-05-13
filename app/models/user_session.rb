class UserSession < Authlogic::Session::Base

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

end