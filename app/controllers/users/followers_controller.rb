# frozen_string_literal: true

class Users::FollowersController < ApplicationController
  def index
    @followers = User.find(params[:user_id]).followers.order(:id).page(params[:page]).per(10)
  end
end
