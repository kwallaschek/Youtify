class Song < ApplicationRecord
  belongs_to :playlist
  validates :yid, presence: true
  #validates :start_timecode, length: { minimum: 4, maximum: 7 }
  #validates :stop_timecode, length: { minimum: 4, maximum: 7 }
end
