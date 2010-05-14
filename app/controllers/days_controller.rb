class DaysController < ApplicationController

  def index
    @days = Game.find(params[:game_id]).days.find(:all) do
#      order_by "#{params[:sidx]} #{params[:sord]}"
      paginate :page => params[:page], :per_page => params[:rows]
    end

    @days.sort! { |a,b| a.seq <=> b.seq }
    
    respond_to do |format|
      format.json { render :json => @days.to_jqgrid_json([:seq, :'votes.length', :'unresolved_votes.length', :'players.length', :to_lynch, :high_vote], params[:page], params[:rows], @days.total_entries) }
    end
  end

  def votes
    @votes = Day.find(params[:id]).votes.find(:all) do
#      order_by "#{params[:sidx]} #{params[:sord]}"
      paginate :page => params[:page], :per_page => params[:rows]
    end

    @votes.sort! { |a,b| a.seq <=> b.seq }

    respond_to do |format|
      format.json { render :json => @votes.to_jqgrid_json([:seq, :'voter.name', :action, :'target.name', :target_name], params[:page], params[:rows], @votes.total_entries) }
    end
  end
  
  def show
    @game = Game.find(params[:game_id])
    @day = @game.days.find_by_seq(params[:id])
    @tally = @day.tally
    @colorize = params[:colorize] == 'true'
    @bbcode   = params[:bbcode]   == 'true'
    
    respond_to do |format|
      format.html # show.html.erb
      format.json   { render :json => @tally }
      format.xml    { render :xml => @tally  }
    end
  end
  
  def tally
    if params[:game_id].present?
      @game = Game.find(params[:game_id])
      @day = @game.days.find_by_seq(params[:id])
    else
      @day = Day.find(params[:id])
    end
    @tally = @day.tally(params[:through].to_i)
    @colorize = params[:colorize] == 'true'
    @bbcode   = params[:bbcode]   == 'true'
    @official = params[:official] == 'true'
    
    respond_to do |format|
      format.html {
        if request.xhr?
          render :partial => 'tally'
        else
          render :html => 'tally'
        end
      }
      format.json   { render :json => @tally }
      format.xml    { render :xml => @tally  }
    end
  end

end
