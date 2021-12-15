class CandidateDossierfacileFoldersController < ApplicationController
  before_action :authenticate_user!

  def create
    @appointment = Appointment.find(params[:appointment_id])
    #unless params[:candidate_documents]
    #  @appointment.errors.add(:candidate_documents, 'Fichiers non reconnus. Merci de respecter les formats autorisés 🙏')
    #  flash[:warning] = "Fichiers non reconnus. Merci de respecter les formats autorisés 🙏"
    #  redirect_to appointment_path(@appointment)
    #  return
    #end
    @appointment.candidate_dossierfacile_folder.attach(params[:candidate_dossierfacile_folder])
    flash[:success] = "Votre document DossierFacile a bien été ajouté 👌"
    redirect_to appointment_path(@appointment)
  end

  def destroy
    @appointment = Appointment.find(params[:appointment_id])
    @appointment.candidate_dossierfacile_folder.purge
    flash[:success] = "Votre document DossierFacile a bien été supprimé 👌"
    redirect_to appointment_path(@appointment)
  end

  private

  def candidate_dossierfacile_folder_params
    params.require(:appointment).permit(:candidate_dossierfacile_folder)
  end

end