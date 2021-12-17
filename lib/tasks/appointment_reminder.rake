desc "Send reminder email the day before visit D-day"
task appointment_reminder: :environment do
  Appointment.all.each do |a|
    if a.slot.start_date.strftime("%d%m%Y") == (DateTime.now + 1).strftime("%d%m%Y")
      UserMailer.appointment_reminder_email(a).deliver_now
    end
  end
end
