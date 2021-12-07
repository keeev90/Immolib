class Property < ApplicationRecord
  #Associations
  belongs_to :owner, class_name: "User"
  has_many :slots, dependent: :destroy
  has_many :appointments, through: :slots
  has_many :candidates, class_name: "User", through: :appointments
  
  #Validations
  validates :title, presence: true, length: { in: 3..140, message: ": Le nombre de caractères doit être compris entre 3 et 140" }
end
