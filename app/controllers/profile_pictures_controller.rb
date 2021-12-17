class ProfilePicturesController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    unless params[:profile_picture] && ((params[:profile_picture] && params[:profile_picture].content_type == "image/jpeg") || ( params[:profile_picture] && params[:profile_picture].content_type == "image/png" ))
      @user.errors.add(:profile_picture, 'Fichier non reconnu')
      flash[:warning] = "Fichier non reconnu. Merci de respecter les formats autorisés 🙏"
      redirect_to user_path(@user)
      return
    end
    if params[:profile_picture] && params[:profile_picture].size > 3000000
      @user.errors.add(:profile_picture, 'Fichier trop lourd')
      flash[:warning] = "Fichier trop volumineux. Veuillez choisir un fichier de moins de 3 Mo 🙏"
      redirect_to user_path(@user)
      return
    end
    @user.profile_picture.attach(params[:profile_picture])
    flash[:success] = "La photo a bien été ajoutée 👌"
    redirect_to(user_path(@user))
  end

  def destroy
    @user = User.find(params[:user_id])
    @user.profile_picture.purge
    @user.add_default_picture
    flash[:success] = "La photo a bien été supprimée 👌"
    redirect_to user_path(@user)
  end

end
