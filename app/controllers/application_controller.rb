# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters_to_sign_up, if: :devise_controller?
  before_action :configure_permitted_parameters_to_update_account, if: :devise_controller?

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  def configure_permitted_parameters_to_sign_up
    devise_parameter_sanitizer.permit(:sign_up,keys: [:post_code,:address,:self_introduction])
  end

  def configure_permitted_parameters_to_update_account
    devise_parameter_sanitizer.permit(:account_update,keys: [:post_code,:address,:self_introduction])
  end
end
