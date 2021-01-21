require 'rails_helper'

RSpec.feature 'Users' do

  describe "#create" do
    it "is possible to sign up" do
      user = User.new
      user.username = SecureRandom.hex(3)
      user.email = "#{SecureRandom.hex(5)}@#{SecureRandom.hex(3)}.org"
      user.password = SecureRandom.hex(4)
      sign_up(user)
      expect(page).to have_content('successfully signed up')
      expect(page).to have_content('Playlists')
      logout
    end

    it "is possible to login" do
      login(create(:user))
      expect(page).to have_content('Logged in successfully')
      expect(page).to have_content('Playlists')
      logout
    end
  end

  describe "#edit" do
    it "is possible to edit the username" do
      user = create(:user)
      old_name = user.username
      login(user)
      click_on "Profile"
      click_on "Edit Profile"
      expect(current_path).to eq("/users/#{user.id}/edit")
      new_name = SecureRandom.hex(5)
      fill_in "Username", with: new_name
      click_on "Update account"
      expect(page).to have_content('Your account information was successfully updated')
      expect(User.find(user.id).username).to eq(new_name)
      expect(User.find(user.id).username).not_to eq(old_name)
      logout
    end
  end

  describe "#destroy" do
    it "is possible to delete account" do
      user = create(:user)
      u_id = user.id
      old_name = user.username
      login(user)
      click_on "Profile"
      click_on "Delete Profile"
      expect(page).to have_content('Account successfully deleted')
      expect(User.where(id: u_id)).not_to exist
    end
  end
end


