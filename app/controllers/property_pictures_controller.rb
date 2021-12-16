class PropertyPicturesController < ApplicationController
  before_action :authenticate_user!

  def create
    @property = Property.find(params[:property_id])
    unless params[:property_picture]
      @property.errors.add(:property_picture, 'Fichier non reconnu')
      flash[:warning] = "Fichier non reconnu. Essayez à nouveau."
      redirect_to property_path(@property)
      return
    end
    if params[:property_picture] && params[:property_picture].size > 3000000
      @property.errors.add(:property_picture, 'Fichier trop lourd')
      flash[:warning] = "Fichier trop volumineux. Veuillez choisir un fichier de moins de 3 Mo."
      redirect_to property_path(@property)
      return
    end
    @property.property_picture.attach(params[:property_picture])
    flash[:success] = "La photo a bien été ajoutée 👌"
    redirect_to(property_path(@property))
  end

  def destroy
    @property = Property.find(params[:id])
    @property.property_picture.purge
    flash[:success] = "La photo a bien été supprimée 👌"
    redirect_to property_path(@property)
  end

end
