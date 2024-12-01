class Art < ApplicationRecord
  belongs_to :artist

  # validations
  has_one_attached :art_image, dependent: :destroy
  validates :title, presence: true
  validates :description, presence: true
  validates :tags, presence: true
  validates :category, presence: true
  validates :license_type, presence: true

   # Define variants for different resolutions
  def resized_variant(width, height)
      art_image.variant(resize_to_limit: [width, height]).processed
  end
end
