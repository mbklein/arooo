class DaysController < ApplicationController

  def tally
    @game = Game.find(params[:game_id])
    @day = @game.days.find_by_seq(params[:id])
    @tally = @day.tally
    @colorize = params[:colorize] ? true : false
    
    respond_to do |format|
      format.html # tally.html.erb
      format.json   { render :json => @tally }
      format.xml    { render :xml => @tally  }
    end
  end

end
