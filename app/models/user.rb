class User < ApplicationRecord
  #Callbacks
  #after_create :welcome_send

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
