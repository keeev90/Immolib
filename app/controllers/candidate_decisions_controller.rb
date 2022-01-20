class CandidateDecisionsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_candidate?

  def update
    appointment = Appointment.find(params[:appointment_id])
    if params[:appointment][:is_interested] == "true"
      appointment.update(is_interested: params[:appointment][:is_interested])
      flash[:success] = "Votre choix a été enregistré avec succès 👌"
    elsif params[:appointment][:is_interested] == "false"
      if appointment.slot.is_past?
        appointment.update(is_interested: params[:appointment][:is_interested])
      else
        appointment.update(is_interested: params[:appointment][:is_interested], slot_id: nil)
      end
      flash[:success] = "Votre choix a été enregistré avec succès 👌"
    else 
      flash[:warning] = "Merci de sélectionner une réponse 🙏"
    end
    redirect_to appointment_path(appointment)
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