# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
    
  def jqgrid?
    params[:page].present? and params[:rows].present?
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return (current_user_session && current_user_session.user) || nil
  end

  def require_user
    unless current_user
      return false
    end
  end

  def require_no_user
    if current_user
      return false
    end
  end

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
