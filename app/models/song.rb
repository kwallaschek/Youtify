# == Schema Information
#
# Table name: songs
#
#  id           :integer          not null, primary key
#  endSeconds   :integer
#  name         :string
#  position     :integer
#  songDuration :integer
#  startSeconds :integer
#  yid          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  playlist_id  :integer
#
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
      if t[2].nil?
        super(t[0].to_i*60 + t[1].to_i)
      else
        super(t[0].to_i*3600 + t[1].to_i*60 + t[2].to_i)
      end
    end
    rescue
      super(time)
  end

  def endSeconds=(time)
    if time.include? ":"
      t = time.split(":")
      if t[2].nil?
        super(t[0].to_i*60 + t[1].to_i)
      else
        super(t[0].to_i*3600 + t[1].to_i*60 + t[2].to_i)
      end
    end
    rescue
      super(time)
  end
end
