class UserMailer < ApplicationMailer
  default from: ENV['EMAIL_FROM']
 
  def welcome_email(user)
    @user = user 
    @url  = "https://immolib-dev.herokuapp.com/users/sign_in" 
    @subtitle = "Bienvenue 👋"
    mail(to: @user.email, subject: "Bienvenue sur immolib ! 👋") 
  end

  def new_property_validation_email(property)
    @property = property
    @user = property.owner
    @subtitle = "Confirmation de création de votre logement immolib 🎉"
    mail(to: @user.email, subject: "Confirmation de création de votre logement immolib 🎉")
  end

  def new_appointment_validation_email(appointment)
    @appointment = appointment
    @user = appointment.candidate
    @subtitle = "Confirmation de votre visite 🎉"
    mail(to: @user.email, subject: "Confirmation de votre visite 🎉")
  end

  def candidate_folder_reminder_email(appointment)
    @appointment = appointment
    @user = appointment.candidate
    @subtitle = "Compléter votre dossier candidat 📋"
    mail(to: @user.email, subject: "Compléter votre dossier candidat 📋")
  end

  def appointment_reminder_email(appointment)
    @appointment = appointment
    @user = appointment.candidate
    @subtitle = "J-1 avant votre visite ⏰"
    mail(to: @user.email, subject: "J-1 avant votre visite ⏰")
  end

end
