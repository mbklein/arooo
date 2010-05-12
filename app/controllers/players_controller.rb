class PlayersController < ApplicationController

  def update
    attrs = Player.match_attributes(params)
    if params[:id] == '_empty'
      @player = Player.new(attrs) 
      @success = @player.save
    else
      @player = Player.find(params[:id])
      @success = @player.update_attributes(attrs)
    end

    respond_to do |format|
      if @success
        flash[:notice] = 'Player was successfully updated.'
        format.html { redirect_to(@player) }
        format.json { render :json => @player }
        format.xml  { render :xml  => @player }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @Player.errors, :status => :unprocessable_entity }
        format.xml  { render :xml  => @Player.errors, :status => :unprocessable_entity }
      end
    end
  end

end