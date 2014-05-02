class TripController < ApplicationController
  before_filter :current_admin?, only: [:index, :destroy]
  before_filter :authorized_user?, only: [:show]

  def show
  end

  def index
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  protected

  def authorized_user?
    current_admin? || (current_user && current_user.id == params[:user_id])
  end
end