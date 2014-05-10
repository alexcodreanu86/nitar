class UsersController < ApplicationController
  # before_filter :current_admin?, only: [:index]
  # before_filter :authorized_user?, only: [:show]
  def show
    @user = User.where(id: params[:id]).first
    redirect_to root_path if !@user
  end


  def index
    @users = User.all.order(:name)
  end

  protected
  def authorized_user?
    current_admin? || (current_user && current_user.id == params[:id])
  end
end