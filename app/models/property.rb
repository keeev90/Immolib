class Property < ApplicationRecord
  #Associations
  belongs_to :owner, class_name: "User"
  has_many :slots
  has_many :appointments, through: :slots
  has_many :candidates, class_name: "User", through: :appointments

end
