class Song < ApplicationRecord
  belongs_to :playlist
  validates :name, presence: true
  validates :yid, presence: true, length: { is: 11 }
  validates :startSeconds, length: { minimum: 1, maximum: 4 }, numericality: { only_integer: true }
  validates :endSeconds, length: { minimum: 1, maximum: 4 }, numericality: { only_integer: true }
  validates :songDuration, length: { minimum: 1, maximum: 4 }, numericality: { only_integer: true }
  validate :timesInOrder

  def timesInOrder
    errors.add :base, :invalid, message: I18n.t('errorEbD') if endSeconds > songDuration
    errors.add :base, :invalid, message: I18n.t('errorSbE') if startSeconds > endSeconds
  end

  def startSeconds=(time)
    if time.include? ":"
      t = time.split(":")
      super(t[0].to_i*60 + t[1].to_i)
    end
    rescue
      super(time)
  end

  def endSeconds=(time)
    if time.include? ":"
      t = time.split(":")
      super(t[0].to_i*60 + t[1].to_i)
    end
    rescue
      super(time)
  end
end
