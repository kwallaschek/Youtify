FactoryBot.define do
  factory :playlist do
    name { SecureRandom.hex(3) }
    user_id { create(:user).id }
  end
end