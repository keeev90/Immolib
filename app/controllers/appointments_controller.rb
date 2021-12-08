class AppointmentsController < ApplicationController
  def index
  end

  def new
  end

  def create
    appointment = Appointment.create(candidate: current_user, slot: Slot.find(params[:param1]))
    redirect_to appointment_path(appointment.id)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
