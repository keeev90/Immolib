class Slot < ApplicationRecord
  #Associations
  belongs_to :property

  has_many :appointments, dependent: :destroy
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
    start_date..end_date
  end

  def duration? #converts seconds into minutes
    (end_date - start_date).to_i/(60) #https://stackoverflow.com/questions/4502245/how-can-i-find-the-number-of-days-between-two-date-objects-in-ruby
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

  def start_must_be_before_end_date #https://stackoverflow.com/questions/6401374/rails-validation-method-comparing-two-fields
    errors.add(:start_date, "La date de fin doit être postérieure à la date de début") unless start_date < end_date
  end

  def overlaps_with_other? # https://railsguides.net/date-ranges-overlap/
    # other_slots = Property.find(params[:property_id]).slots
    if (self.property)
      other_slots = self.property.slots
      is_overlapping = other_slots.any? do |other_slot| # any? method >>> https://www.geeksforgeeks.org/ruby-enumerable-any-function/#:~:text=The%20any%3F()%20of%20enumerable,condition%2C%20else%20it%20returns%20false.&text=Parameters%3A%20The%20function%20takes%20two,the%20other%20is%20the%20pattern.
        period.overlaps?(other_slot.period) # overlaps? method >>> https://www.rubydoc.info/docs/rails/Range:overlaps%3F
      end
      errors.add(:overlaps_with_other?, "Un créneau de visite existe déjà sur cette période") if is_overlapping
    end

  end
  
  
end
