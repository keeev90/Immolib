class Property < ApplicationRecord
  #Callbacks
  before_create :randomize_property_id
  before_validation :create_stripe_product
  after_commit :add_default_picture, on: [:create, :update]

  #Associations
  belongs_to :owner, class_name: "User"
  has_many :slots, dependent: :destroy
  has_many :appointments#, through: :slots
  has_many :candidates, class_name: "User", through: :appointments
  has_one_attached :property_picture, dependent: :destroy
  
  #Validations
  validates :title, presence: true, length: { in: 3..140 }
  validates :city, presence: true
  #validates :zip_code, presence: true, format: { with: /\A(([0-8][0-9])|(9[0-5])|(2[ab]))[0-9]{3}\z/, message: "Veuillez entrer un code postal valide" } 
  validates :other_link, format: URI::regexp(%w[http https]), allow_blank: true
  validates :owner_project, presence: true, allow_blank: false
  validates :property_picture, size: {less_than: 3.megabytes, message: 'must be less than 3MB'}

  def go_visit_url
    @id = self.id
    return "https://immolib.herokuapp.com/properties/#{@id}/go-visit"
  end
  
  def go_visit_url_short
    @id = self.id
    return "immolib.herokuapp.com/properties/#{@id}/go-visit"
  end

  def go_visit_url_dev
    @id = self.id
    return "https://immolib-dev.herokuapp.com/properties/#{@id}/go-visit"
  end

  def go_visit_url_local
    @id = self.id
    return "localhost:3000/properties/#{@id}/go-visit"
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

  def has_available_slot?
    ans = false
    self.slots.each do |slot|
      unless slot.is_past?
        slot.available? ? (return ans = true) : nil
      end
    end
    return ans
  end

  def available_slots
    count = 0
    self.slots.each do |slot|
      unless slot.is_past?
        if slot.available?
          count += 1
        end
      end
    end
    return count
  end

  def can_book?(candidate)
    self.slots.each do |slot|
      unless slot.is_past? 
        slot.candidates.include?(candidate) ? (return false) : nil
      end
    end
    return true
  end
  #slot.candidates.include?(current_user)

  def future_slots
    future_slots_array = []
    self.slots.each do |slot|
      if slot.start_date > DateTime.now
        future_slots_array << slot
      end
    end
    return future_slots_array
  end

  def has_future_slots?
    result = false
    if self.future_slots.size > 0
      return result = true
    end
    return result
  end

  private

  def stripe_price
    Stripe::Price.retrieve(self.stripe_price_id)
  end

  def stripe_product
    Stripe::Product.retrieve(self.stripe_price.product)
  end

  def add_default_picture
    unless property_picture.attached?
      self.property_picture.attach(
        io: File.open(
          Rails.root.join('app', 'assets', 'images', 'property_placeholder.png')
        ),
        filename: 'property_placeholder.png',
        content_type: 'image/png'
      )
    end
  end

  def randomize_property_id
    begin
      self.id = SecureRandom.random_number(1_000_000)
    end while Property.where(id: self.id).exists?
    #self.id = 5.times.map { rand(1..9) }.join.to_i
  end

  def create_stripe_product
    unless self.stripe_price_id
      stripe_product = Stripe::Product.create({
        name: "1 logement immolib",
        description: "#{title} - #{city}"
      })

      # Stripe::Product.update(
      #   stripe_product.id,
      #   {images: [image_url]},
      # ) if self.image_url !=""

      stripe_price = Stripe::Price.create({
        product: stripe_product.id,
        unit_amount: 2999,
        currency: 'eur'
      })

      self.stripe_price_id = stripe_price.id

      self.save
    end
  end
end
