class Appointment < ApplicationRecord
  #Associations
  belongs_to :candidate, class_name: "User"
  belongs_to :slot
  has_one :property, through: :slot

  #Validations
  validates :candidate_message, length: { in: 10..1000 }, allow_blank: true

end
