class PlayersController < ApplicationController

  def update
    attrs = Player.match_attributes(params)
    if params[:id] == '_empty'
      @player = Player.new(attrs)
      if can_moderate?(@player.game)
        @success = @player.save
      else
        @success = false
      end
    else
      @player = Player.find(params[:id])
      if can_moderate?(@player.game)
        @success = @player.update_attributes(attrs)
      else
        @success = false
      end
    end

    respond_to do |format|
      format.html { redirect_to(@player) }
      format.json { render :json => @player }
      format.xml  { render :xml  => @player }
    end
  end

end