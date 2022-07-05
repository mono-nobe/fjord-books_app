# frozen_string_literal: true

class FollowsController < ApplicationController
  def create
    followed_user = User.find(params[:followed_user_id])
    current_user.follow(followed_user)

    redirect_back fallback_location: user_path(followed_user.id)
  end

  def destroy
    followed_user = User.find(params[:id])
    current_user.unfollow(followed_user)

    redirect_back fallback_location: user_path(followed_user.id)
  end
end
