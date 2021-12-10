class AppointmentsController < ApplicationController
  def index
  end

  def new
  end

  def create
    slot = Slot.find(params[:param1])
    @property = Property.find(params[:property])
    user_appointments = Appointment.where(candidate: current_user)
    @appointment = Appointment.new(candidate: current_user, slot: slot)
    if @appointment.save
      user_appointments.each do |appointment|
        if appointment.property == @property && appointment != @appointment then appointment.destroy end
      end
      redirect_to appointment_path(@appointment)
    else
      redirect_to appointment_path(old_appointment)
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    @slots = @appointment.property.slots
    @date_arr = ["", "jan.", "fév.", "mar.", "avr.", "mai", "juin", "juil.", "août", "sept.", "oct.", "nov.", "déc."]
  end

  def edit
  end

  def update
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @property = Property.find(params[:property])
    @appointment.destroy
    redirect_to book_now_property_path(@property)
  end
end
