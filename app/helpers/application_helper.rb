# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def can_moderate?(game)
    current_user_session.can_moderate?(game)
  end

  def can_observe?(game)
    current_user_session.can_observe?(game)
  end

  def can_view?(game)
    current_user_session.can_view?(game)
  end

end
