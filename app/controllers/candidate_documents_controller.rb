class CandidateDocumentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @appointment = Appointment.find(params[:appointment_id])
    #unless params[:candidate_documents]
    #  @appointment.errors.add(:candidate_documents, 'Fichiers non reconnus. Merci de respecter les formats autorisés 🙏')
    #  flash[:warning] = "Fichiers non reconnus. Merci de respecter les formats autorisés 🙏"
    #  redirect_to appointment_path(@appointment)
    #  return
    #end
    @appointment.candidate_documents.attach(params[:candidate_documents])
    flash[:success] = "Votre fichier a bien été ajouté 👌"
    redirect_to appointment_path(@appointment)
  end

  def destroy
    @appointment = Appointment.find(params[:appointment_id])
    @doc = ActiveStorage::Attachment.find(params[:id])
    #@appointment.candidate_documents.purge
    @doc.purge

    flash[:success] = "Votre fichier a bien été supprimé 👌"
    redirect_to appointment_path(@appointment)
  end

  private

  def candidate_documents_params
    params.require(:appointment).permit(candidate_documents: [])
  end

end