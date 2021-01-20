FactoryBot.define do
  factory :song do
    name { SecureRandom.hex(3) }
    yid { "0123456789A" }
    startSeconds { 0 }
    endSeconds { 100 }
    songDuration { 100 }
    playlist_id { create(:playlist).id }
  end
end
