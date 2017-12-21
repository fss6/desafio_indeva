class GoalsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_goal, only: [:show, :destroy]

  # GET /goals
  # GET /goals.json
  def index
    @goals = Goal.all
  end

  # GET /goals/1
  # GET /goals/1.json
  def show
  end

  # GET /goals/new
  def new
    @goal = Goal.new
  end

  # POST /goals
  # POST /goals.json
  def create
    @goal = Goal.new(goal_params)
    respond_to do |format|
      if @goal.save
        puts @goal.errors.inspect
        format.html { redirect_to @goal, flash: helper_success(:created) }
        format.json { render :show, status: :created, location: goals_url }
      else
        format.html { render :new }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.json
  def destroy
    respond_to do |format|
      if @goal.destroy
        format.html { redirect_to goals_url, flash: helper_success(:destroyed) }
        format.json { head :no_content }
      else
        format.html { redirect_to goals_url, flash: helper_errors(@goal) }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = Goal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      params.require(:goal).permit(:name, :store_id, :start_date, :end_date, :total_value,
      daily_goals_attributes: [:value, :goal_date, seller_ids: []])
    end
end
