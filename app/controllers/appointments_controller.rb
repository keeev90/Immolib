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
    @appointment = Appointment.find(params[:id])
  end

  def update
    @appointment = Appointment.find(params[:id])
    @property = @appointment.slot.property.id

    if @appointment.update(candidate_message: params[:appointment][:candidate_message])
      flash[:success] = "Votre candidature a été enregistrée avec succès 👌"
      redirect_to appointment_path(@appointment)
    else
      flash[:warning] = @appointment.errors.full_messages
      redirect_to send_message_property_path(@property)
    end
  end

  def destroy
    redirect_to_book_now = params[:redirect_to_book_now]
    @appointment = Appointment.find(params[:id])
    @property = Property.find(params[:property])
    @appointment.destroy
    if redirect_to_book_now == "true"
      redirect_to book_now_property_path(property)
    else
      redirect_to appointment_path(new_appointment)
    end
  end
end
