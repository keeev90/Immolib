class UsersController < ApplicationController
  before_action :is_same_user, :authenticate_user!
  def index

  end

  def show
    @user = User.find(params[:id])
  end

  def update

  end

  def destroy

  end

  private

  def is_same_user
    @user = User.find(params[:id])
    if @user == current_user
      # Ajouter flash success
    else
      # Ajouter flash alert
      redirect_to root_path
    end
  end

end
