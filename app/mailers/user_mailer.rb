class UserMailer < ApplicationMailer
  default from: ENV['EMAIL_FROM']
 
  def welcome_email(user)
    @user = user 
    @subtitle = "Merci pour votre inscription"
    mail(to: @user.email, subject: "Bienvenue sur immolib 👋") 
  end

  def new_property_validation_email(property)
    @property = property
    @user = property.owner
    @subtitle = "Merci pour votre confiance"
    mail(to: @user.email, subject: "Votre logement immolib a bien été créé 🎉")
  end

  def new_appointment_information_email(appointment)
    @property = appointment.property
    @user = @property.owner
    @subtitle = "Rendez-vous sur votre espace immolib pour accéder à ses informations détaillées"
    mail(to: @user.email, subject: "Vous avez un nouveau candidat 🎉")
  end

  def new_appointment_validation_email(appointment)
    @appointment = appointment
    @user = appointment.candidate
    @subtitle = "Rendez-vous sur votre espace immolib pour compléter vos informations"
    mail(to: @user.email, subject: "Votre candidature est bien enregistrée 🎉")
  end

  def candidate_folder_reminder_email(appointment)
    @appointment = appointment
    @user = appointment.candidate
    @subtitle = "Rendez-vous sur votre espace immolib pour finaliser votre dossier"
    mail(to: @user.email, subject: "Votre dossier de location est incomplet 📋")
  end

  def appointment_reminder_email(appointment)
    @appointment = appointment
    @user = appointment.candidate
    @subtitle = "Consultez les instructions logistiques pour votre visite"
    mail(to: @user.email, subject: "J-1 avant votre visite ⏰")
  end

end
