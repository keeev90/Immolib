class Slot < ApplicationRecord
  #Callbacks
  after_commit :add_default_picture, on: [:create, :update]
  
  #Associations
  belongs_to :property
  has_many :appointments
  has_many :candidates, through: :appointments
  
  #Validations
  validate :start_date_cannot_be_in_the_past
  validate :overlaps_with_other?

  validates :start_date, presence: true
  validates :duration, presence: true
  validates :max_appointments, presence: true, numericality: { only_integer: true }

  def end_date
    start_date + duration.minutes
  end

  def period
    start_date..(end_date-1)
  end

  def duration? #converts seconds into minutes
    (end_date - start_date).to_i/(60)
  end

  def availability
    return (self.max_appointments - self.appointments.size)
  end
  
  def available?
    if self.availability > 0
      return true
    else
      return false
    end
  end

  def is_past?
    self.start_date < DateTime.now
  end

  private

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < DateTime.now
      errors.add(:start_date, "Impossible de créer ou modifier un créneau de visite dans le passé.")
    end
  end

  def start_must_be_before_end_date
    errors.add(:start_date, "La date de fin doit être postérieure à la date de début") unless start_date < end_date
  end

  def overlaps_with_other?
    if (self.property)
      other_slots = self.property.slots
      is_overlapping = other_slots.any? do |other_slot|
        if other_slot != self
        period.overlaps?(other_slot.period)
        end
      end
      errors.add(:overlaps_with_other?, "Un créneau de visite existe déjà sur cette période") if is_overlapping
    end
  end
  
  def add_default_picture
    
  end
end
