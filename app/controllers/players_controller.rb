class PlayersController < ApplicationController

  def update
    @player = Player.find(params[:id])
    if can_moderate?(@player.game)
      attrs = Player.match_attributes(params)
      @success = @player.update_attributes(attrs)
    else
      @success = false
    end

    respond_to do |format|
      format.html { redirect_to(@player) }
      format.json { render :json => @player }
      format.xml  { render :xml  => @player }
    end
  end

end