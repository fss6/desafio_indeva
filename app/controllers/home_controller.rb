class HomeController < ApplicationController
  def index
    @sellers_count = current_owner.sellers.count
    @stores_count = current_owner.stores.count
    @goals_count = current_owner.goals.count
  end
end
