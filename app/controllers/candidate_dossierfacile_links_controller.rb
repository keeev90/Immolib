class CandidateDossierfacileLinksController < ApplicationController
  before_action :authenticate_user!

  def create
    appointment = Appointment.find(params[:appointment_id])
    appointment.update(candidate_dossierfacile_link: params[:candidate_dossierfacile_link])
    flash[:success] = "Votre lien DossierFacile a bien été ajouté 👌"
    redirect_to appointment_path(appointment)
  end

  def destroy
    appointment = Appointment.find(params[:appointment_id])
    appointment.candidate_dossierfacile_link = ""
    appointment.save
    flash[:success] = "Votre lien DossierFacile a bien été supprimé 👌"
    redirect_to appointment_path(appointment)
  end

end