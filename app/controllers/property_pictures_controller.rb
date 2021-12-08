class PropertyPicturesController < ApplicationController
  before_action :authenticate_user!

  def create
    @property = Property.find(params[:property_id])
    unless params[:property_picture]
      @property.errors.add(:property_picture, 'Fichier non reconnu')
      flash.now[:warning] = "Fichier non reconnu. Essayez à nouveau."
      render :create
      return
    end
    @property.property_picture.attach(params[:property_picture])
    flash[:success] = "La photo a bien été ajoutée."
    redirect_to(property_path(@property))
  end

  def destroy
    @property = Property.find(params[:id])
    @property.property_picture.purge
    redirect_to property_path(@property)
  end

end
