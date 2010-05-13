# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def can_moderate?(game)
    rights(game).can_moderate?
  end
  
  def can_observe?(game)
    rights(game).can_observe?
  end
  
  def can_view?(game)
    rights(game).can_view?
  end
  
  def rights(game)
    return current_user_session && current_user_session.rights(game)
  end
  
end
