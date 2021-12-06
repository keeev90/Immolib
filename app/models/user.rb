class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #Associations
  has_many :properties, foreign_key: 'owner_id'
  has_many :appointments, foreign_key: 'candidate_id'
  
  #Validations
  # validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Merci de renseigner une adresse email valide." }
end
