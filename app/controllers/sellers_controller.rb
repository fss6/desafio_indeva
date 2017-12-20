class SellersController < ApplicationController
  before_action :set_seller, only: [:edit, :update, :destroy]

  # GET /sellers
  # GET /sellers.json
  def index
    @q = current_owner.sellers.ransack(params[:q])
    # abort params.inspect
    @sellers = @q.result(distinct: true)
  end

  # GET /sellers/new
  def new
    @seller = Seller.new
  end

  # GET /sellers/1/edit
  def edit
  end

  # POST /sellers
  # POST /sellers.json
  def create
    @seller = Seller.new(seller_params.merge(owner_id: current_owner.id))

    respond_to do |format|
      if @seller.save
        format.html { redirect_to sellers_url, flash: helper_success(:created) }
        format.json { render :show, status: :created, location: @seller }
      else
        helper_render_errors(@seller)
        format.html { render :new}
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sellers/1
  # PATCH/PUT /sellers/1.json
  def update
    respond_to do |format|
      if @seller.update(seller_params)
        format.html { redirect_to sellers_url, flash: helper_success(:updated) }
        format.json { render :show, status: :ok, location: @seller }
      else
        helper_render_errors(@seller)
        format.html { render :edit }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sellers/1
  # DELETE /sellers/1.json
  def destroy
    respond_to do |format|
      if @seller.destroy
        format.html { redirect_to sellers_url, flash: helper_success(:destroyed) }
        format.json { head :no_content }
      else
        format.html { redirect_to sellers_url, flash: helper_errors(@seller) }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seller
      @seller = Seller.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seller_params
      params.require(:seller).permit(:registration, :name, :owner_id)
    end
end
