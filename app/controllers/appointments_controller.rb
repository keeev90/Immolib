class AppointmentsController < ApplicationController
  def index
  end

  def new
  end

  def create
    slot = Slot.find(params[:param1])
    redirect_to_book_now = params[:redirect_to_book_now]
    property = Property.find(params[:property])
    user_appointments = Appointment.where(candidate: current_user) # on stock les rdv du user
    already_an_appointment = false
    new_appointment = Appointment.new(candidate: current_user, slot: slot)
    user_appointments.each do |appointment| #on parcourt les rdv du user
      if appointment.property == property #si on en trouve un pour la meme property
        new_appointment =  appointment #on stock le rdv
        new_appointment.slot = slot #on update le slot
        already_an_appointment = true #on dit que le candidat avait déja un rdv sur ce logement
      end
    end


    if new_appointment.save #Si la sauvegarde du RDV fonctionne bien
      if redirect_to_book_now == "true"
        redirect_to book_now_property_path(property)
      else
        redirect_to appointment_path(new_appointment)
      end
    else
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
