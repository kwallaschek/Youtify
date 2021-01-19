class Song < ApplicationRecord
  belongs_to :playlist
  validates :name, presence: true
  validates :yid, presence: true, length: { is: 11 }
  validates :startSeconds, length: { minimum: 1, maximum: 4 }, numericality: { only_integer: true }
  validates :endSeconds, length: { minimum: 1, maximum: 4 }, numericality: { only_integer: true }
  validates :songDuration, length: { minimum: 1, maximum: 4 }, numericality: { only_integer: true }
end
