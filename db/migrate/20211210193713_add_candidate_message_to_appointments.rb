class AddCandidateMessageToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :candidate_message, :text
  end
end
