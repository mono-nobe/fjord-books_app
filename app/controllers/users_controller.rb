class UsersController < ApplicationController

  def index
    @users = User.order(:email).page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
  end
end
