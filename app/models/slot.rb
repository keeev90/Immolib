class Slot < ApplicationRecord
  #Associations
  belongs_to :property
  has_many :appointments
  has_many :candidates, through: :appointments
  
  validate :start_date_cannot_be_in_the_past

  validates :start_date, presence: true

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end   
end
