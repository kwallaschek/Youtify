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
FactoryBot.define do
  factory :song do
    name { SecureRandom.hex(3) }
    yid { "bwmSjveL3Lc" }
    startSeconds { 0 }
    endSeconds { 100 }
    songDuration { 100 }
    playlist_id { create(:playlist).id }
  end
end
