class Art < ApplicationRecord
  belongs_to :artist

  has_one_attached :art_image, dependent: :destroy
end
