class UserMailer < ApplicationMailer
  default from: 'Immolib <immolib@yopmail.com>'
 
  def welcome_email(user)
    @user = user 
    @subtitle = "Merci pour votre inscription"
    mail(to: @user.email, subject: "Bienvenue sur immolib 👋") 
  end

  def new_property_validation_email(property)
    @property = property
    @user = property.owner
    @subtitle = "Merci pour votre confiance"
    mail(to: @user.email, subject: "Votre logement est enregistré 🎉")
  end

  def new_appointment_information_email(appointment)
    @appointment = appointment
    @property = appointment.property
    @user = @property.owner
    @subtitle = "Rendez-vous sur votre espace immolib pour gérer les candidatures"
    mail(to: @user.email, subject: "Vous avez un nouveau candidat 🎉")
  end

  def new_appointment_validation_email(appointment)
    @appointment = appointment
    @user = appointment.candidate
    @subtitle = "Rendez-vous sur votre espace immolib pour compléter vos informations"

    # Create a calendar with an event
    cal = Icalendar::Calendar.new
    cal.event do |e|
      e.dtstart     = Icalendar::Values::DateTime.new(appointment.slot.start_date)
      e.dtend       = Icalendar::Values::DateTime.new(appointment.slot.end_date)
      e.summary     = "Visite du logement '#{appointment.property.title}' à #{appointment.property.city}"
    end
    cal.publish
    attachments['event.ics'] = { mime_type: 'text/calendar', content: cal.to_s }

    mail(to: @user.email, subject: "Votre candidature est enregistrée 🎉")
  end

  def candidate_folder_reminder_email(appointment)
    @appointment = appointment
    @user = appointment.candidate
    @subtitle = "Rendez-vous sur votre espace immolib pour finaliser votre dossier"
    mail(to: @user.email, subject: "Votre dossier est incomplet 📋")
  end

  def appointment_reminder_email(appointment)
    @appointment = appointment
    @user = appointment.candidate
    @subtitle = "Consultez les informations logistiques pour votre visite"
    mail(to: @user.email, subject: "J-1 avant votre visite ⏰")
  end

end
