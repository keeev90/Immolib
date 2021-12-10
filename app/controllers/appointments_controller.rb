class AppointmentsController < ApplicationController
  def index
  end

  def new
  end

  def create
    slot = Slot.find(params[:param1])
    @property = Property.find(params[:property])
    user_appointments = Appointment.where(candidate: current_user)
    @appointment = Appointment.new(candidate: current_user, slot: slot)
    redirect_to_book_now = true
    if @appointment.save #Si la sauvegarde du RDV fonctionne bien
      user_appointments.each do |appointment| #Pour chaque RDV du candidat
        if appointment.property == @property && appointment != @appointment #Si le rdv correspond à un rdv sur cette property et que ce n'est pas le rdv actuel
          appointment.destroy # alors je suprimme le rdv
          redirect_to_book_now = false # et je redirige vers appointment show
        end
      end
      if redirect_to_book_now
        #redirect to book now
      else
        redirect_to appointment_path(@appointment)
      end
    else
      redirect_to appointment_path(old_appointment)
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    @slots = @appointment.property.slots
    @date_arr = ["", "jan.", "fév.", "mar.", "avr.", "mai", "juin", "juil.", "août", "sept.", "oct.", "nov.", "déc."]
  end

  def edit
  end

  def update
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @property = Property.find(params[:property])
    @appointment.destroy
    redirect_to book_now_property_path(@property)
  end
end
