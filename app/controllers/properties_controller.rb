class PropertiesController < ApplicationController
  before_action :authenticate_user!, except: [:welcome_candidate]
  before_action :is_owner?, only: [:show]

  # user as potential ower

  def new
    @property = Property.new
  end 

  def create
    @property = Property.new(property_params)
    @property.owner = current_user
    
    if @property.save
      flash[:success] = "La présentation de votre logement a été créée avec succès ✌️"
      redirect_to(property_slots_path(@property))
    else
      flash.now[:warning] = @property.errors.full_messages
      render :new
    end
  end 

  # user as owner

  def index
    @properties = current_user.properties
  end

  def show
    @property = Property.find(params[:id])
    @date_arr = ["", "jan.", "fév.", "mar.", "avr.", "mai", "juin", "juil.", "août", "sept.", "oct.", "nov.", "déc."]

    respond_to do |format|
      format.html
      format.js
    end
  end 

  def edit
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    
    edited_property = params[:property]

    if @property.update(title: edited_property[:title], city: edited_property[:city], other_link: edited_property[:other_link], instructions: edited_property[:instructions])
      flash[:success] = "Votre annonce a été éditée avec succès 👌"
      redirect_to property_path(@property)
    else
      flash.now[:warning] = @property.errors.full_messages
      render :edit
    end
  end

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    if current_user.is_admin?
      flash[:success] = "Le logement a bien été supprimé 👌"
      redirect_to admin_root_path
    else  
      flash[:success] = "Votre logement a bien été supprimé 👌"
      redirect_to user_path(current_user)
    end
  end

  # user as potential candidate

  def welcome_candidate
    @property = Property.find(params[:id])
  end

  private

  def property_params
    params.require(:property).permit(:owner_project, :title, :city, :property_picture, :other_link, :instructions)
  end

  def is_owner?
    @property = Property.find(params[:id])
    if @property.owner != current_user && !current_user.is_admin?
      flash[:warning] = "Vous n'avez pas l'autorisation d'accéder à ceci ⛔"
      redirect_to root_path
    end
  end
end
