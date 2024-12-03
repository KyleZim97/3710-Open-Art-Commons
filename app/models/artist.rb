class Artist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # constants
    # none yet

  # relationships
  has_many :arts , dependent: :destroy
  
  # validations
  validates :username, presence: true
  validates :about_artist, presence: true
  validates :created, presence: true
  validates :password_confirmation, presence: true, if: -> { password.present? }
end
