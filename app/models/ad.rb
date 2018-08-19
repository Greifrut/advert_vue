class Ad < ApplicationRecord
  belongs_to :user

  has_attached_file :image, default_url: "/images/missing.png"

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  validates :title, presence: true
  validates :description, presence: true

  def image_url
    image.url
  end
end


