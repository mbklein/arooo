class DaysController < ApplicationController

  def index
    @days = Game.find(params[:game_id]).days.find(:all) do
      order_by "#{params[:sidx]} #{params[:sord]}"
      paginate :page => params[:page], :per_page => params[:rows]
    end

    respond_to do |format|
      format.json { render :json => @days.to_jqgrid_json([:seq, :'votes.length', :'unresolved_votes.length', :'players.length', :to_lynch, :high_vote], params[:page], params[:rows], @days.total_entries) }
    end
  end

  def show
    @game = Game.find(params[:game_id])
    @day = @game.days.find_by_seq(params[:id])
    @tally = @day.tally
    @colorize = params[:colorize] ? true : false
    
    respond_to do |format|
      format.html # show.html.erb
      format.json   { render :json => @tally }
      format.xml    { render :xml => @tally  }
    end
  end
  
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
