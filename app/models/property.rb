class Property < ApplicationRecord
  #Callbacks
  before_create :create_application_link

  #Associations
  belongs_to :owner, class_name: "User"
  has_many :slots
  has_many :appointments, through: :slots
  has_many :candidates, class_name: "User", through: :appointments
  has_one :link

  private 

  def create_application_link
    #générer un token
    token = SecureRandom.uuid[0..2]

    #mettre dans une colonne de property
    self.id = token

    #créer le lien unique
    @url = "https://immolib-dev.herokuapp.com/#{token}" #lien redirection vers parcours de candidature pour la property
    link = Link.create(property: self, url: @url)

    #créer le slug unique > https://immolib-dev.herokuapp.com/visiter-1
    @slug_root = "prendre-rdv" 
    link.update(slug: @slug + "-" + self.id)
  end

end
