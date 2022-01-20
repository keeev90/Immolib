class OwnerDecisionsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_owner?

  def update
    appointment = Appointment.find(params[:appointment_id])
    property = appointment.property
    if params[:appointment][:is_accepted] == "true"
      appointment.update(is_accepted: params[:appointment][:is_accepted])
      flash[:success] = "Votre réponse a été enregistrée avec succès 👌"
    elsif params[:appointment][:is_accepted] == "false"
      appointment.update(is_accepted: params[:appointment][:is_accepted], slot_id: nil)
      flash[:success] = "Votre réponse a été enregistrée avec succès 👌"
    else 
      flash[:warning] = "Merci de sélectionner une réponse 🙏"
    end
    redirect_to property_path(property)
  end

  private

  def is_owner?
    property = Appointment.find(params[:appointment_id]).property
    if property.owner == current_user
    elsif current_user.is_admin?
    else
      flash[:warning] = "Vous n'avez pas l'autorisation d'accéder à cette page ⛔"
      redirect_to root_path
    end
  end

end