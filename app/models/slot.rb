class Slot < ApplicationRecord
  #Associations
  belongs_to :property
  has_many :appointments
  has_many :candidates, through: :appointment

end
