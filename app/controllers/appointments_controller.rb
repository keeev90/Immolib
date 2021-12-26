class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_candidate?, only: [:show, :edit]

  # user as potential candidate

  def index
  end

  def new
  end

  def create
    slot = Slot.find(params[:param1])
    new_candidate = params[:new_candidate]
    property = Property.find(params[:property])
    user_appointments = Appointment.where(candidate: current_user)
    already_an_appointment = false
    new_appointment = Appointment.new(candidate: current_user, slot: slot)
    user_appointments.each do |appointment|
      if appointment.property == property && !appointment.slot.is_past?
        new_appointment =  appointment
        new_appointment.slot = slot 
        already_an_appointment = true
      end
    end

    if new_appointment.save
      if new_candidate == "true"
        redirect_to step_1_property_path(property)
      else
        redirect_to appointment_path(new_appointment)
      end
    end
  end

  # user as candidate

  def show
    @appointment = Appointment.find(params[:id])
    @slots = @appointment.property.slots
    @date_arr = ["", "jan.", "fév.", "mar.", "avr.", "mai", "juin", "juil.", "août", "sept.", "oct.", "nov.", "déc."]
  end

  def edit 
  end

  def update 
    #slot
    new_candidate = params[:new_candidate]
    if new_candidate == "false"
      slot = Slot.find(params[:param1])
      property = Property.find(params[:property])
      user_appointments = Appointment.where(candidate: current_user)
      #already_an_appointment = false
      user_appointments.each do |appointment|
        if appointment.property == property #&& !appointment.slot.is_past?
          appointment.update(slot: slot)
          redirect_to appointment_path(appointment)
          #already_an_appointment = true
        end
      end
    end
  end

  def destroy
    appointment = Appointment.find(params[:id])
    user = appointment.candidate
    appointment.destroy
    if params[:owner]
      flash[:success] = "Le rendez-vous a bien été annulé. Le candidat est automatiquement prévenu 👌"
      redirect_to property_path(appointment.slot.property)
    else
      if appointment.property.owner_project == "rent" 
        flash[:success] = "Votre candidature a bien été annulée. Les documents de votre dossier sont automatiquement supprimés 👌"
      else
        flash[:success] = "Votre candidature a bien été annulée 👌"
      end
      redirect_to user_path(user)
    end
  end

  private

  def redirect_path
    params.require(:appointment).permit(:redirect_path)
  end

  def is_candidate?
    @appointment = Appointment.find(params[:id])
    if @appointment.candidate != current_user && !current_user.is_admin?
      flash[:warning] = "Vous n'avez pas l'autorisation d'accéder à cette page ⛔"
      redirect_to root_path
    end
  end

end
