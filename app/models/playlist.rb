class Playlist < ApplicationRecord
  belongs_to :user
  has_many :songs, dependent: :destroy
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :user_id, presence: true
end
