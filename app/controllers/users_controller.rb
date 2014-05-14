class UsersController < ApplicationController
  before_filter :authorize_admin, only: [:index]
  before_filter :authorize_user, only: [:show]

  def show
    @user = User.where(id: params[:id]).first
  end


  def index
    @users = User.all.order(:name)
  end

  def destroy
    @user = User.where(id: params[:id]).first
    @user.destroy
    flash[:notice] = "#{@user.name}'s account has been deleted!"
    redirect_to :back
  end

  protected
  def authorize_user
    unless current_admin? || (current_user && current_user.id == params[:id].to_i)
      unauthorized_user
    end
  end
end