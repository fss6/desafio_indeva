class ApplicationController < ActionController::Base
  include ApplicationHelper::Flash
  protect_from_forgery with: :exception
  before_action :authenticate_owner!
  before_action :devise_permitted_parameters, if: :devise_controller?

  protected
    def devise_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
