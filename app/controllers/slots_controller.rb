class SlotsController < ApplicationController

  # user as potential owner

  def new_first
    @slot = Slot.new
    @property = Property.find(params[:id])
    @minutes = Array.new(12).each_with_index.map { |n, i| (i + 1) * 15 }
    now = DateTime.now
    min = now.minute / 15 * 15 + 15
    @date = now.change(
      {
        hour: min >= 60 ? now.hour + 1 : now.hour,
        min: min % 60
      }
    )
  end

  def index_first
    @property = Property.find(params[:id]) # for Stripe
    @slots = Property.find(params[:id]).slots
  end

  # user as owner

  def new
    @slot = Slot.new
    @property = Property.find(params[:property_id])
    @minutes = Array.new(12).each_with_index.map { |n, i| (i + 1) * 15 }
    now = DateTime.now
    min = now.minute / 15 * 15 + 15
    @date = now.change(
      {
        hour: min >= 60 ? now.hour + 1 : now.hour,
        min: min % 60
      }
    )
  end

  def index # not used (show with calendar instead)
    @property = Property.find(params[:property_id]) # for Stripe
    @slots = Property.find(params[:property_id]).slots
  end

  def show
    @slot = Slot.find(params[:id])
    @date_arr = ["", "janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"]
  end

  def show_candidate_details
    @appointment = Appointment.find(params[:appointment])
    respond_to do |format|
      format.js {}
    end
  end

  # user as both potential owner and owner
  
  def create
    @property = Property.find(params[:property_id])
    @minutes = Array.new(12).each_with_index.map { |n, i| (i + 1) * 15 }
    @slot = Slot.new(slot_params)
    @slot.property = @property
    if @slot.save
      flash[:success] = "Le créneau de visite a été ajouté avec succès ✌️"
      if redirect_path[:redirect_path] == "check if new immolib property process" #when in new immolib property process
        redirect_to(new_slots_property_path(@property))
      else #when in "mon espace immolib"
        redirect_to(property_path(@property))
      end
    else
      flash[:warning] = @slot.errors.full_messages
      if redirect_path[:redirect_path] == "check if new immolib property process" #when new immolib property process
        redirect_to(new_slot_property_path(@property))
      else #when in "mon espace immolib"
        render :new
      end
    end
  end

  def edit
    @slot = Slot.find(params[:id])
    @date_arr = ["", "janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"]
    @property = @slot.property
    @minutes = Array.new(12).each_with_index.map { |n, i| (i + 1) * 15 }
    @date = @slot.start_date
  end

  def update
    @property = Property.find(params[:property_id])
    @slot = Slot.find(params[:id])
    @slot.update(slot_params)
    if @slot.save
      flash[:success] = "Le créneau de visite a été edité avec succès ✌️"
        redirect_to(property_path(@property))
    else
      flash.now[:warning] = @slot.errors.full_messages
      render :new
    end
  end

  def destroy
    slot = Slot.find(params[:id])
    property = slot.property
    slot.destroy
    flash[:success] = "Le créneau a bien été supprimé. Il ne sera plus accesible aux candidats 👌"
    redirect_to(property_path(property))
  end

  # user as potential candidate

  def book_candidate
    @property = Property.find(params[:id])
    @slots = @property.slots
    @redirect_to_book_now = true
    @date_arr = ["", "jan.", "fév.", "mar.", "avr.", "mai", "juin", "juil.", "août", "sept.", "oct.", "nov.", "déc."]
  end

  private


  def slot_params
    params.require(:slot).permit(
      :start_date,
      :duration,
      :max_appointments
    )
  end

  def redirect_path
    params.require(:slot).permit(:redirect_path)
  end

end
