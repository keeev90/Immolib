class Property < ApplicationRecord
  #Callbacks
  before_create :randomize_property_id

  #Associations
  belongs_to :owner, class_name: "User"
  has_many :slots, dependent: :destroy
  has_many :appointments, through: :slots
  has_many :candidates, class_name: "User", through: :appointments
  has_one_attached :property_picture
  
  #Validations
  validates :title, presence: true, length: { in: 3..140 }
  validates :city, presence: true
  #validates :zip_code, presence: true, format: { with: /\A(([0-8][0-9])|(9[0-5])|(2[ab]))[0-9]{3}\z/, message: "Veuillez entrer un code postal valide" } 
  validates :other_link, format: URI::regexp(%w[http https]), allow_blank: true


  def go_visit_url
    @id = self.id
    return "https://immolib.herokuapp.com/properties/#{@id}/go-visit"
  end

  def go_visit_url_dev
    @id = self.id
    return "https://immolib-dev.herokuapp.com/properties/#{@id}/go-visit"
  end

  def go_visit_url_local
    @id = self.id
    return "http://localhost:3000/properties/#{@id}/go-visit"
  end

  def already_has_appointment?(user)
    result = false
    self.candidates.each do |cand|
      if cand == user
        result = true
      end
    end
    return result
  end

  private

  def randomize_property_id
    begin
      self.id = SecureRandom.random_number(1_000_000)
    end while Property.where(id: self.id).exists?
    #self.id = 5.times.map { rand(1..9) }.join.to_i
  end

end
