class SlotsController < ApplicationController
  def index
    @property = Property.find(params[:property_id]) # for Stripe
    @slots = Property.find(params[:property_id]).slots
  end

  def index_candidate
    @slots = Property.find(params[:id]).slots
    @property = Property.find(params[:id])
    @date_arr = ["", "jan.", "fév.", "mar.", "avr.", "mai", "juin", "juil.", "août", "sept.", "oct.", "nov.", "déc."]
  end

  def show
    @slot = Slot.find(params[:id])
    @date_arr = ["", "janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"]
  end

  def new
    @slot = Slot.new
    @property = Property.find(params[:property_id])
    @minutes = Array.new(12).each_with_index.map { |n, i| (i + 1) * 15 }
  end

  def create
    @property = Property.find(params[:property_id])
    @slot = Slot.new(slot_params)
    @slot.property = @property
    if @slot.save
      flash[:success] = "Le créneau de visite a été ajouté avec succès ✌️"
      redirect_to(property_slots_path(@property))
    else
      flash.now[:warning] = @slot.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private


  def slot_params
    params.require(:slot).permit(
      :start_date,
      :duration,
      :max_appointments
    )
  end

end
