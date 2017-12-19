class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  # GET /stores
  # GET /stores.json
  def index
    @stores = current_owner.stores
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  end

  # GET /stores/new
  def new
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params.merge(owner_id: current_owner.id))

    respond_to do |format|
      if @store.save
        format.html { redirect_to stores_url, flash: helper_success(:created) }
        format.json { render :show, status: :created, location: @store }
      else
        helper_render_errors(@store)
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to stores_url, flash: helper_success(:updated) }
        format.json { render :show, status: :ok, location: @store }
      else
        helper_render_errors(@store)
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    respond_to do |format|
      if @store.destroy
        format.html { redirect_to stores_url, flash: helper_success(:destroyed) }
        format.json { head :no_content }
      else
        format.html { redirect_to stores_url, flash: helper_errors(@store) }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:name, :owner_id, seller_ids: [])
    end
end
