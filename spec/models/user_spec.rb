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
require 'rails_helper'

RSpec.describe User, type: :model do

  describe "#valid?" do

    it "is valid if the factory is used" do
      user = create(:user)
      expect(user).to be_valid
    end

    it "is valid when email is unique" do
      u1 = create(:user)
      user = User.new
      user.username = "tests"
      user.email = "unique@example.org"
      user.password = "test"
    expect(user.valid?).to be true
    end

    it "is invalid if email is taken" do
      create(:user, email: "testInvalid@test.com")
      user = User.new
      user.username = "test2"
      user.email = "testInvalid@test.com"
      user.password = "test"
      expect(user.valid?).not_to be true
    end

    it "is invalid if username is taken" do
      create(:user, username: "testTaken")
      user = User.new
      user.username = "testTaken"
      user.email = "test2@test.com"
      user.password = "test"
      expect(user.valid?).not_to be true
    end

    it "is invalid if username is blank" do
      user = create(:user)
      expect(user).to be_valid

      user.username = ""
      expect(user).not_to be_valid

      user.username = nil
      expect(user).not_to be_valid
    end

    it "is invalid if no valid email is given" do
      user = create(:user)
      expect(user).to be_valid

      user.email = "bla"
      expect(user).to be_invalid

      user.email = "bla@"
      expect(user).to be_invalid

      user.email = "bla.co"
      expect(user).to be_invalid

      user.email = "bla@asdf"
      expect(user).to be_invalid

      user.email = "bla@fds.sdf.d"
      expect(user).to be_valid
    end
  end

  describe "#playlists" do
    it "can list all of the user's playlists" do
      user = create(:user)
      user2 = create(:user)

      pl1 = create(:playlist, user: user)
      pl2 = create(:playlist, user: user)
      pl3 = create(:playlist, user: user)

      pl4 = create(:playlist, user: user2)
      pl5 = create(:playlist, user: user2)

      expect(user.playlists).to include(pl1, pl2, pl3)
      expect(user2.playlists).to include(pl4, pl5)
    end

    it "deletes all of users playlists if the user is deleted" do
      user = create(:user)
      user_id = user.id
      user2 = create(:user)

      create(:playlist, user: user)
      create(:playlist, user: user)
      create(:playlist, user: user)
      user.destroy

      pl4 = create(:playlist, user: user2)
      pl5 = create(:playlist, user: user2)

      expect(user2.playlists).to include(pl4, pl5)
      expect(Playlist.where(user_id: user_id)).not_to exist
    end

    it "deletes all songs of a playlist that is owned by a user that gets deleted" do
      user = create(:user)
      user_id = user.id

      pl1 = create(:playlist, user: user)
      pl1_id = pl1.id
      pl2 = create(:playlist, user: user)
      pl2_id = pl2.id
      create(:song, playlist: pl1)
      create(:song, playlist: pl1)
      create(:song, playlist: pl2)
      create(:song, playlist: pl2)

      user.destroy

      expect(Playlist.where(user_id: user_id)).not_to exist
      expect(Song.where(playlist_id: pl1_id)).not_to exist
      expect(Song.where(playlist_id: pl2_id)).not_to exist
    end
  end
end
