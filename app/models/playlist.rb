# == Schema Information
#
# Table name: playlists
#
#  id                     :integer          not null, primary key
#  background_job_running :boolean
#  description            :text
#  name                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :integer
#
class Playlist < ApplicationRecord
  belongs_to :user
  has_many :songs, dependent: :destroy
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :user_id, presence: true
end
