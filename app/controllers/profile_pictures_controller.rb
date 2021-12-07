class ProfilePicturesController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    unless params[:profile_picture]
      @user.errors.add(:profile_picture, 'Fichier non reconnu')
      flash.now[:warning] = "Fichier non reconnu. Essayez à nouveau."
      render :create
      return
    end
    @user.profile_picture.attach(params[:profile_picture])
    flash[:success] = "La photo a bien été ajoutée."
    redirect_to(user_path(@user))
  end

end
