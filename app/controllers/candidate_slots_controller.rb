class CandidateSlotsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_candidate?

  def update
    new_candidate = params[:new_candidate]
    slot = Slot.find(params[:new_slot])
    appointment = Appointment.find(params[:appointment_id])
    if new_candidate == "false" && !slot.is_past?
      appointment.update(slot: slot)
      flash[:success] = "Votre créneau de visite a bien été mis à jour 👌"
      redirect_to appointment_path(appointment)
    else 
      flash[:warning] = "Une erreur s'est produite, merci de rééssayer 🙏"
      redirect_to appointment_path(appointment)
    end
  end

  def destroy
    #to do with delete icon on slot card
  end

  private

  def is_candidate?
    @appointment = Appointment.find(params[:appointment_id])
    if @appointment.candidate == current_user
    elsif current_user.is_admin?
    else
      flash[:warning] = "Vous n'avez pas l'autorisation d'accéder à cette page ⛔"
      redirect_to root_path
    end
  end

end