class UserSession < Authlogic::Session::Base

  class << self
    def anonymous_session
      if @anonymous_session.nil?
        @anonymous_session = UserSession.new

        class << @anonymous_session
          def user ; nil  ; end
          def save ; true ; end
          def can_moderate?(game) ; false                                   ; end
          def can_observe?(game)  ; game.over                               ; end
          def can_view?(game)     ; game.over || game.allow_anonymous_view  ; end
        end
      end
      @anonymous_session
    end

    def find(*args)
      begin
        super(*args) || anonymous_session
      rescue
        anonymous_session
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
