# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters_to_sign_up, if: :devise_controller?
  before_action :configure_permitted_parameters_to_update_account, if: :devise_controller?

  def after_sign_up_path_for(*)
    books_path
  end

  def after_sign_in_path_for(*)
    books_path
  end

  def after_sign_out_path_for(*)
    new_user_session_path
  end

  def configure_permitted_parameters_to_sign_up
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[post_code address self_introduction])
  end

  def configure_permitted_parameters_to_update_account
    devise_parameter_sanitizer.permit(:account_update, keys: %i[post_code address self_introduction])
  end
end
