# frozen_string_literal: true

class Users::FollowingsController < ApplicationController
  def index
    @followings = User.find(params[:user_id]).following.order(:id).page(params[:page]).per(10)
  end
end
