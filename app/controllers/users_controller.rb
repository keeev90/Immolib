class UsersController < ApplicationController
  before_action :is_same_user, :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    edited_user = params[:user]

    if @user.update(first_name: edited_user[:first_name], last_name: edited_user[:last_name])
      flash[:success] = "Votre profil a été édité avec succès 👌"
      redirect_to user_path(@user)
    else
      flash.now[:warning] = @user.errors.full_messages
      render edit_user_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "Votre compte a été supprimé avec succès. Nous espérons vous revoir bientôt 👋"
    redirect_to root_path
  end

  private

  def is_same_user
    @user = User.find(params[:id])
    if @user == current_user
    elsif current_user.is_admin?
    else
      flash[:warning] = "Vous n'êtes pas autorisé à accéder à cette page ⛔"
      redirect_to root_path
    end
  end

end
