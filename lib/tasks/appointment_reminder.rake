desc "Envoyer un email rappel à J-1 avant la visite"
task appointment_reminder: :environment do
  Appointment.all.each do |a|
    if a.slot.start_date.strftime("%d%m%Y") == (DateTime.now + 1).strftime("%d%m%Y")
      UserMailer.appointment_reminder_email(a).deliver_now
    end
  end
end
