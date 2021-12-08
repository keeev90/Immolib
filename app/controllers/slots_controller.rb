class SlotsController < ApplicationController
  def index
    @property = Property.find(params[:property_id]) # for Stripe
    @slots = Property.find(params[:property_id]).slots
  end

  def index_candidate
    @slots = Property.find(params[:id]).slots
  end

  def show
  end

  def new
    @slot = Slot.new
    @property = Property.find(params[:property_id])
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
    params.require(:slot).permit(:start_date, :duration, :max_appointments)
  end

end
