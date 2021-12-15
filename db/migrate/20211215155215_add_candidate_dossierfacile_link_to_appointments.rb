class AddCandidateDossierfacileLinkToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :candidate_dossierfacile_link, :string
  end
end
