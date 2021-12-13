class AppointmentsController < ApplicationController

  # user as potential candidate

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

  def message_candidate
    @property = Property.find(params[:id])
    @appointment = current_user.appointments.last
  end

  # user as candidate

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
      if redirect_path[:redirect_path] == "check if new immolib appointment process" #when in new immolib appointment process
        flash[:success] = "Votre candidature a été enregistrée avec succès ✌️"
      else #when in "mon espace immolib"
        flash[:success] = "Votre message a été édité avec succès 👌"
      end
      redirect_to appointment_path(@appointment)
    else
      flash[:warning] = @appointment.errors.full_messages
      if redirect_path[:redirect_path] == "check if new immolib appointment process" #when in new immolib appointment process
        redirect_to send_message_property_path(@property)
      else #when in "mon espace immolib"
        render :edit
      end
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

  private

  def redirect_path
    params.require(:appointment).permit(:redirect_path)
  end

end
