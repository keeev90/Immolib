class User < ApplicationRecord
  #Callbacks
  #after_create :welcome_send
  after_commit :add_default_picture, on: [:create, :update]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  #Associations
  has_many :properties, foreign_key: 'owner_id', dependent: :destroy
  has_many :appointments, foreign_key: 'candidate_id', dependent: :destroy
  has_one_attached :profile_picture, dependent: :destroy

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  def add_default_picture
    unless profile_picture.attached?
      self.profile_picture.attach(
        io: File.open(
          Rails.root.join('app', 'assets', 'images', 'profile_placeholder.png')
        ),
        filename: 'profile_placeholder.png',
        content_type: 'image/png'
      )
    end
  end
  
  def past_appointments
    past_appointments_array = []
    self.appointments.each do |appointment|
      if appointment.slot.start_date < DateTime.now
        past_appointments_array << appointment
      end
    end
    return past_appointments_array
  end

  def future_appointments
    future_appointments_array = []
    self.appointments.each do |appointment|
      if appointment.slot.start_date > DateTime.now
        future_appointments_array << appointment
      end
    end
    return future_appointments_array
  end

  private

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
