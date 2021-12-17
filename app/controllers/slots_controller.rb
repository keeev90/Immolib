class SlotsController < ApplicationController
  before_action :authenticate_user!, only: [:book_candidate]

  # for new property only

  def index
    @property = Property.find(params[:property_id]) # for Stripe
    @slots = Property.find(params[:property_id]).slots
  end

  # for both new property and existing property

  def new
    @redirect_path_value = redirect_path_new
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
  
  def create
    redirect_path_value = redirect_path_create.values.first
    nb = nb_slots[:nb_slots].to_i
    one_is_success = false
    new_start_date = slot_params[:start_date].to_datetime
    duration = slot_params[:duration].to_i
    property = Property.find(params[:property_id])
    @property = Property.find(params[:property_id])
    @minutes = Array.new(12).each_with_index.map { |n, i| (i + 1) * 15 }
    slot = ""
    nb.times do |index|
      slot = Slot.new(slot_params)
      slot.property = property
      slot.start_date = new_start_date
      if slot.save then one_is_success = true end
      new_start_date = new_start_date + duration.minutes
    end
    if one_is_success
      flash[:success] = "Le créneau de visite a été ajouté avec succès ✌️"
      if redirect_path_value == "new_property" #when new immolib property process
        redirect_to(property_slots_path(property))
      else #when in "mon espace immolib"
        redirect_to(property_path(property))
      end
    else
      flash[:warning] = slot.errors.full_messages
      if redirect_path_value == "new_property" #when new immolib property process
        redirect_to(new_property_slot_path(property, redirect_path: "new_property"))
      else #when in "mon espace immolib"
        redirect_to(new_property_slot_path(property, redirect_path: "existing_property"))
      end
    end
  end

  def destroy
    slot = Slot.find(params[:id])
    property = slot.property
    slot.destroy
    flash[:success] = "Le créneau a bien été supprimé. Il ne sera plus accesible et les candidats inscrits sont automatiquement prévenus 👌"
    if params[:new_property]
      redirect_to property_slots_path(property)
    else
      redirect_to(property_path(property))
    end
  end

  # for existing property only

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
      flash[:success] = "Le créneau de visite a été edité avec succès. Les candidats inscrits sont automatiquement prévenus ✌️"
        redirect_to(property_path(@property))
    else
      flash.now[:warning] = @slot.errors.full_messages
      render :new
    end
  end

  # for candidate

  def book_candidate
    @property = Property.find(params[:id])
    @slots = @property.slots
    @redirect_to_book_now = true
    @date_arr = ["", "jan.", "fév.", "mar.", "avr.", "mai", "juin", "juil.", "août", "sept.", "oct.", "nov.", "déc."]

    respond_to do |format|
      format.html
      format.js
    end
  end

  def before_book_candidate
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

  def nb_slots
    params.require(:slot).permit(
      :nb_slots
    )
  end

  def redirect_path_new
    params[:redirect_path]
  end

  def redirect_path_create
    params.require(:slot).permit(:redirect_path)
  end

end
