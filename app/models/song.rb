class Song < ApplicationRecord
  belongs_to :playlist
  validates :name, presence: true
  validates :yid, presence: true, length: { is: 11 }
  validates :startSeconds, length: { minimum: 1, maximum: 4 }, numericality: { only_integer: true }
  validates :endSeconds, length: { minimum: 1, maximum: 4 }, numericality: { only_integer: true }
  validates :songDuration, length: { minimum: 1, maximum: 4 }, numericality: { only_integer: true }
  validate :timesInOrder

  def timesInOrder
    errors.add :base, :invalid, message: t('errorEbD') unless endSeconds <= songDuration
    errors.add :base, :invalid, message: t('errorSbE') unless startSeconds < endSeconds
  end

  def startSeconds=(time)
    if time.include? ":"
      t = time.split(":")
      p t[0].to_i*60 + t[1].to_i
      super(t[0].to_i*60 + t[1].to_i)
    else
      super(time)
    end
  end

  def endSeconds=(time)
    if time.include? ":"
      t = time.split(":")
      p t[0].to_i*60 + t[1].to_i
      super(t[0].to_i*60 + t[1].to_i)
    else
      super(time)
    end
  end
end
