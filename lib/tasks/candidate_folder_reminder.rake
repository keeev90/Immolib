desc "Send email alert to user two days before visit when partial candidate folder"
task candidate_folder_reminder: :environment do
  Appointment.all.each do |a|
    if ( a.slot.start_date.strftime("%d%m%Y") == (DateTime.now + 2).strftime("%d%m%Y") ) && ( a.slot.property.owner_project == "rent" )
      unless a.candidate_dossierfacile_link || a.candidate_dossierfacile_folder.attached? || a.candidate_documents.size >= 5
        UserMailer.candidate_folder_reminder_email(a).deliver_now
      end
    end
  end
end