class Property < ApplicationRecord
  #Callbacks
  after_create :update_property_id

  #Associations
  belongs_to :owner, class_name: "User"
  has_many :slots, dependent: :destroy
  has_many :appointments, through: :slots
  has_many :candidates, class_name: "User", through: :appointments
  has_one_attached :property_picture
  
  #Validations
  validates :title, presence: true, length: { in: 3..140, message: "Le nombre de caractères doit être compris entre 3 et 140" }

  def go_visit_url
    @id = self.id
    return "https://immolib-dev.herokuapp.com/properties/#{@id}/go-visit"
  end

  private

  def update_property_id
    self.id = 5.times.map { rand(1..9) }.join.to_i
  end

end
