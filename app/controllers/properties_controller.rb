class PropertiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @properties = current_user.properties
  end

  def show
    @property = Property.find(params[:id])
  end 

  def new
    @property = Property.new
  end 

  def create
    @property = Property.new(property_params)
    @property.owner = current_user
    if @property.save
      flash[:success] = "La présentation de votre logement a été créée avec succès 😎"
      redirect_to(property_slots_path(@property))
    else
      flash.now[:warning] = @property.errors.full_messages
      render :new
    end
  end 

  private

  def property_params
    params.require(:property).permit(:title, :city, :other_link, :instructions)
  end

end
