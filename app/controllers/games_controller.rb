class GamesController < ApplicationController
  # GET /games
  # GET /games.xml
  def index
    @games = Game.find(:all) do
#      order_by "#{params[:sidx]} #{params[:sord]}"
      paginate :page => params[:page], :per_page => params[:rows]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
      format.json { 
        if jqgrid?
          render :json => @games.to_jqgrid_json([:id, :title, :'moderator.name', :'players.length', :'days.length'], params[:page], params[:rows], @games.total_entries) 
        else
          render :json => @games.to_json(:include => { 
            :moderator => { }, :players => { :methods => [:name], :except => [:role, :alignment, :fate, :person_id, :game_id, :death_day_id] }
          }, :except => [:moderator_id, :server_id, :id])
        end
      }
    end
  end

  def days
    if params[:id].present?
      params[:game_id] = params.delete(:id)
      redirect_to params.merge({:controller => :days, :action => :index})
    else
      render :json => [].to_jqgrid_json([:seq, :votes, :unresolved_votes, :players, :to_lynch, :high_vote], 1, 1, 0)
    end
  end
  
  def players
    @players = Game.find(params[:id]).players.find(:all) do
#      order_by "#{params[:sidx]} #{params[:sord]}"
      paginate :page => params[:page], :per_page => params[:rows]
    end

    @players.sort! { |a,b| a.seq <=> b.seq }

    respond_to do |format|
      format.json { render :json => @players.to_jqgrid_json([:seq, :name, :role, :alignment, :fate], params[:page], params[:rows], @players.total_entries) }
    end
  end
  
  # GET /games/1
  # GET /games/1.xml
  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/new
  # GET /games/new.xml
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.xml
  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        flash[:notice] = 'Game was successfully created.'
        format.html { redirect_to(@game) }
        format.xml  { render :xml => @game, :status => :created, :location => @game }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.xml
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        flash[:notice] = 'Game was successfully updated.'
        format.html { redirect_to(@game) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.xml
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
      format.xml  { head :ok }
    end
  end
end
