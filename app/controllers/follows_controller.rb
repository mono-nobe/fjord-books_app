class FollowsController < ApplicationController
  def create
    puts "##### create #####"
    puts params[:current_user]

    user = User.find(params[:current_user])
    current_user.follow(user)
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end
end
