# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :user do
    username { SecureRandom.hex(10) }
    email { "#{SecureRandom.hex(5)}@#{SecureRandom.hex(3)}.org" }
    password { SecureRandom.hex(5) }
  end
end

def sign_up(user)
  visit signup_path
  fill_in "Username", with: user.username
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign Up"
end

def login(user)
  visit "/login"
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Login"
end

def logout()
  visit "/"
  click_on "Logout"
  expect(page).to have_content('Logged out')
end
