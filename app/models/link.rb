class Link < ApplicationRecord

  #Associations
  belongs_to :property 

  #Validations
  validates_presence_of :url
  validates :url, format: URI::regexp(%w[http https])
  #validates_uniqueness_of :slug

  private

  def short
    Rails.application.routes.url_helpers.short_url(slug: self.slug)
  end

  def self.shorten(url, slug = '')
    # return short when URL with that slug was created before
    link = Link.where(url: url, slug: slug).first
    return link.short if link 
      
    # create a new
    link = Link.new(url: url, slug: slug)
    return link.short if link.save
      
    # if slug is taken, try to add random characters
    Link.shorten(url, slug + SecureRandom.uuid[0..2])
  end

end
