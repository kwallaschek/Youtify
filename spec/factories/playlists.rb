# == Schema Information
#
# Table name: playlists
#
#  id                     :integer          not null, primary key
#  background_job_running :boolean
#  description            :text
#  name                   :string
#  repeat                 :boolean
#  shuffle                :boolean
#  ytPlSize               :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :integer
#
FactoryBot.define do
  factory :playlist do
    name { SecureRandom.hex(3) }
    user_id { create(:user).id }
  end
end
