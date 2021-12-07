class Slot < ApplicationRecord
  #Associations
  belongs_to :property
  has_many :appointments, dependent: :destroy
  has_many :candidates, through: :appointment

end
