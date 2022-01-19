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

    if @user.update(first_name: edited_user[:first_name], last_name: edited_user[:last_name], phone_number: edited_user[:phone_number])
      flash[:success] = "Votre profil a été édité avec succès 👌"
      redirect_to user_path(@user)
    else
      flash.now[:warning] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    if params[:admin] 
      flash[:success] = "Utilisateur supprimé avec succès. 💪"
      redirect_to admin_root_path
    else
      flash[:success] = "Votre compte a été supprimé avec succès. Nous espérons vous revoir bientôt 👋"
      redirect_to root_path
    end
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
