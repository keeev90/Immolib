class OwnerDecisionsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_owner?

  def update
    appointment = Appointment.find(params[:appointment_id])
    property = appointment.property
    if appointment.update(is_accepted: params[:appointment][:is_accepted])
      if params[:appointment][:is_accepted] == ( "true" || "false")
        flash[:success] = "Votre réponse a été enregistrée avec succès 👌"
      else 
        flash[:warning] = "Vous n'avez pas sélectionné une réponse, merci de rééssayer 🙏"
      end
      redirect_to property_path(property)
    else 
      flash[:warning] = "Une erreur s'est produite, merci de rééssayer 🙏"
      redirect_to property_path(property)
    end
  end

  private

  def is_owner?
    property = Appointment.find(params[:appointment_id]).property
    if property.owner != current_user
      flash[:warning] = "Vous n'avez pas l'autorisation d'accéder à cette page ⛔"
      redirect_to root_path
    end
  end

end