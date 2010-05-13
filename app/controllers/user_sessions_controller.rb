class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @current_user_session = UserSession.new
    render :partial => 'session'
  end
  
  def create
    user_session = UserSession.new(params[:user_session])
    if user_session.save
      @current_user_session = user_session
    end
    render :partial => 'session'
  end
  
  def destroy
    current_user_session.destroy
    render :partial => 'session'
  end
end
