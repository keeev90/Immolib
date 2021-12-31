class CandidateMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_candidate?

  def edit 
    @appointment = Appointment.find(params[:appointment_id])
  end

  def update
    @appointment = Appointment.find(params[:appointment_id])
    @property = @appointment.slot.property.id

    if @appointment.update(candidate_message: params[:appointment][:candidate_message])
      if redirect_path[:redirect_path] == "new_candidate" #when in new candidate process
        redirect_to step_3_property_path(@property)
        UserMailer.new_appointment_validation_email(@appointment).deliver_now
        UserMailer.new_appointment_information_email(@appointment).deliver_now
      else #when in appointment show
        flash[:success] = "Votre message a été mis à jour avec succès 👌"
        redirect_to appointment_path(@appointment)
      end
    else
      flash[:warning] = @appointment.errors.full_messages
      if redirect_path[:redirect_path] == "new_candidate" #when in new candidate process
        redirect_to step_2_property_path(@property)
      else #when in appointment show
        render :edit
      end
    end
  end

  def destroy
    appointment = Appointment.find(params[:appointment_id])
    appointment.candidate_message = ""
    appointment.save
    flash[:success] = "Votre message a bien été supprimé 👌"
    redirect_to appointment_path(appointment)
  end

  private

  def redirect_path
    params.require(:appointment).permit(:redirect_path)
  end

  def is_candidate?
    @appointment = Appointment.find(params[:appointment_id])
    if @appointment.candidate != current_user && !current_user.is_admin?
      flash[:warning] = "Vous n'avez pas l'autorisation d'accéder à cette page ⛔"
      redirect_to root_path
    end
  end

end