class CandidateDocumentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @appointment = Appointment.find(params[:appointment_id])
    unless params[:candidate_documents]
     @appointment.errors.add(:candidate_documents, 'Fichiers non reconnus. Merci de respecter les formats autorisés 🙏')
     flash[:warning] = "Fichiers non reconnus. Merci de respecter les formats autorisés 🙏"
     redirect_to appointment_path(@appointment)
     return
    end
    params[:candidate_documents].each do |doc|
      if doc.size > 3000000
        @appointment.errors.add(:candidate_document, 'Fichier trop lourd')
        flash[:warning] = "Fichiers trop volumineux. Veuillez choisir des fichiers de moins de 3 Mo chacun 🙏"
        redirect_to appointment_path(@appointment)
        return
      elsif doc.content_type != "application/pdf" && doc.content_type != "image/jpeg" && doc.content_type != "image/png" && doc.content_type != "image/bmp" 
        @appointment.errors.add(:candidate_document, 'Fichiers non reconnus. Merci de respecter les formats autorisés 🙏')
        flash[:warning] = "Fichiers non reconnus. Merci de respecter les formats autorisés 🙏"
        redirect_to appointment_path(@appointment)
        return
      end
    end
    @appointment.candidate_documents.attach(params[:candidate_documents])
    flash[:success] = "Vos fichiers ont bien été ajoutés 👌"
    redirect_to appointment_path(@appointment)
  end

  def destroy
    @appointment = Appointment.find(params[:appointment_id])
    @doc = ActiveStorage::Attachment.find(params[:id])
    @doc.purge
    flash[:success] = "Votre fichier a bien été supprimé 👌"
    
    respond_to do |format|
      format.html { redirect_to appointment_path(@appointment) }
      format.js
    end
  end

  private

  def candidate_documents_params
    params.require(:appointment).permit(candidate_documents: [])
  end

end