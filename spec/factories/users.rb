FactoryBot.define do
  factory :user do
    username { SecureRandom.hex(10) }
    email { "#{SecureRandom.hex(5)}@#{SecureRandom.hex(3)}.org" }
    password { SecureRandom.hex(5) }
  end
end