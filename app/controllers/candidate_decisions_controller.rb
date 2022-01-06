class CandidateDecisionsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_candidate?

  def update
    appointment = Appointment.find(params[:appointment_id])
    if appointment.update(is_interested: params[:appointment][:is_interested])
      if params[:appointment][:is_interested] == ( "true" || "false")
        flash[:success] = "Votre choix a été enregistré avec succès 👌"
      else 
        flash[:warning] = "Vous n'avez pas sélectionné une réponse, merci de rééssayer 🙏"
      end
      redirect_to appointment_path(appointment)
    else 
      flash[:warning] = "Une erreur s'est produite, merci de rééssayer 🙏"
      redirect_to appointment_path(appointment)
    end
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