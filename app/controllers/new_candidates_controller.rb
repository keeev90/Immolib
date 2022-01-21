class NewCandidatesController < ApplicationController
  before_action :authenticate_user!, except: [:welcome_candidate, :step1_logout]
  
  def welcome_candidate
    @property = Property.find(params[:id])
    if @property.already_has_appointment?(current_user) == true
      flash[:warning] = "Vous avez déjà répondu à cette annonce. Merci de gérer votre candidature depuis votre espace immolib 🙏"
      redirect_to user_path(current_user)
    end
  end

  def step1_login #book appointement (if login)
    @property = Property.find(params[:id])
    @new_candidate = true
    @slots = @property.slots
    @date_arr = ["", "jan.", "fév.", "mar.", "avr.", "mai", "juin", "juil.", "août", "sept.", "oct.", "nov.", "déc."]

    respond_to do |format|
      format.html
      format.js
    end
  end

  def step1_logout #before book appointement (if logout)
    @property = Property.find(params[:id])
    @slots = @property.slots
    @new_candidate = true
    @date_arr = ["", "jan.", "fév.", "mar.", "avr.", "mai", "juin", "juil.", "août", "sept.", "oct.", "nov.", "déc."]
  end
  
  def step2 #send message
    @property = Property.find(params[:id])
    @appointment = current_user.appointments.last
  end

  def step3 #go my immolib
    @property = Property.find(params[:id])
    @appointment = current_user.appointments.last
  end

end