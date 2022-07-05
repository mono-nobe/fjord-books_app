# frozen_string_literal: true

class Users::FollowingsController < ApplicationController
  def index
    @followings = User.find(params[:user_id]).following
  end
end
