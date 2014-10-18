class ChangesController < ApplicationController
  before_action :set_change, only: [:show, :edit, :update, :destroy]

  # GET /changes
  # GET /changes.json
  def index
    @changes = Change.order("story_id desc").all

    sfrom = Hash.new
    sto = Hash.new

    @sdiff = Hash.new

    Change.order("story_id, date").all.each do |change|
      timedate = ActiveSupport::TimeZone["Brasilia"].parse(change.date.to_s).to_i

      sfrom[change.story.id.to_s + "-" + change.state_from.order.to_s] = timedate

      if sto[change.story.id.to_s + "-" + change.state_to.order.to_s].nil?
        sto[change.story.id.to_s + "-" + change.state_to.order.to_s] = timedate
      else
        sto[change.story.id.to_s + "-" + change.state_to.order.to_s] = sto[change.story.id.to_s + "-" + change.state_to.order.to_s] + timedate
      end

      puts sto.inspect
      unless sto[change.story.id.to_s + "-" + change.state_from.order.to_s].nil?
        puts timedate - sto[change.story.id.to_s + "-" + change.state_from.order.to_s]
        puts TimeDifference.between(timedate, sto[change.story.id.to_s + "-" + change.state_from.order.to_s]).in_hours
        if @sdiff[change.state_from.title].nil? 
          @sdiff[change.state_from.title] = TimeDifference.between(timedate, sto[change.story.id.to_s + "-" + change.state_from.order.to_s]).in_hours
        else
          @sdiff[change.state_from.title] = @sdiff[change.state_from.title] + TimeDifference.between(timedate, sto[change.story.id.to_s + "-" + change.state_from.order.to_s]).in_hours
        end
      end
    end

  end

  # GET /changes/1
  # GET /changes/1.json
  def show
  end

  # GET /changes/new
  def new
    @change = Change.new
  end

  # GET /changes/1/edit
  def edit
  end

  # POST /changes
  # POST /changes.json
  def create
    @change = Change.new(change_params)

    respond_to do |format|
      if @change.save
        format.html { redirect_to @change, notice: 'Change was successfully created.' }
        format.json { render :show, status: :created, location: @change }
      else
        format.html { render :new }
        format.json { render json: @change.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /changes/1
  # PATCH/PUT /changes/1.json
  def update
    respond_to do |format|
      if @change.update(change_params)
        format.html { redirect_to @change, notice: 'Change was successfully updated.' }
        format.json { render :show, status: :ok, location: @change }
      else
        format.html { render :edit }
        format.json { render json: @change.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /changes/1
  # DELETE /changes/1.json
  def destroy
    @change.destroy
    respond_to do |format|
      format.html { redirect_to changes_url, notice: 'Change was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_change
      @change = Change.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def change_params
      params.require(:change).permit(:story_id, :user_id, :state_from_id, :state_to_id, :date)
    end
end
