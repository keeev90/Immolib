desc "Envoyer un email de rappel en cas de dossier incomplet"
task candidate_folder_reminder: :environment do
  Appointment.all.each do |a|
    if ( a.slot.start_date.strftime("%d%m%Y") == (DateTime.now + 2).strftime("%d%m%Y") ) && ( a.slot.property.owner_project == "rent" )
      if a.candidate_dossierfacile_link
      elsif a.candidate_dossierfacile_folder.attached? 
      elsif a.candidate_documents.size >= 5
      else 
        UserMailer.candidate_folder_reminder_email(a).deliver_now
      end
    end
  end
end