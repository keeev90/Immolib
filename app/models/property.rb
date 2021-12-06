class Property < ApplicationRecord
  #Callbacks
  after_create :create_application_link

  #Associations
  belongs_to :owner, class_name: "User"
  has_many :slots
  has_many :appointments, through: :slots
  has_many :candidates, class_name: "User", through: :appointments
  has_one :link

  private 

  def create_application_link
    @url = "https://immolib-dev.herokuapp.com/#{}" #lien redirection vers parcours de candidature pour la property
    @slug_root = "visiter-mon-logement"
    link = Link.create(property: self, url: @url)
    link.update(slug: @slug + "-" + self.id)
  end

end
