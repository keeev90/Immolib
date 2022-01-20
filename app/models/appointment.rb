class Appointment < ApplicationRecord

  #Associations
  belongs_to :candidate, class_name: "User"
  belongs_to :slot, optional: true
  #has_one :property, through: :slot
  belongs_to :property
  has_many_attached :candidate_documents, dependent: :destroy
  has_one_attached :candidate_dossierfacile_folder, dependent: :destroy

  #Validations
  validates :slot_id, numericality: { only_integer: true }, allow_nil: true
  validates :candidate_message, length: { in: 10..1000 }, allow_blank: true
  validates :candidate_dossierfacile_link, format: URI::regexp(%w[http https]), allow_blank: true

end
