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
require 'rails_helper'

RSpec.describe Playlist, type: :model do
  describe "#valid?" do
    it "is valid if factory is used" do
      pl = create(:playlist)
      expect(pl).to be_valid
    end

    it "is invalid if playlist name is too short" do
      pl = create(:playlist)
      pl.name = ""
      expect(pl).to be_invalid
    end

    it "is invalid if playlist name is too long" do
      pl = create(:playlist)
      pl.name = SecureRandom.hex(55)
      expect(pl).to be_invalid
    end

    it "is invalid if playlist is not owned by a user" do
      pl = create(:playlist)
      pl.user = nil
      expect(pl).to be_invalid
    end
  end

  describe "#songs" do
    it "can list all songs of a playlist" do
      pl = create(:playlist)
      s1 = create(:song, playlist: pl, playlist_id: pl.id)
      s2 = create(:song, playlist: pl, playlist_id: pl.id)
      s3 = create(:song, playlist: pl, playlist_id: pl.id)

      pl2 = create(:playlist)
      s4 = create(:song, playlist: pl2, playlist_id: pl2.id)
      s5 = create(:song, playlist: pl2, playlist_id: pl2.id)

      expect(pl.songs).to include(s1,s2,s3)
      expect(pl2.songs).to include(s4,s5)
    end

    it "deletes all songs of a playlist if it is deleted" do
      pl = create(:playlist)
      s1 = create(:song, playlist: pl, playlist_id: pl.id)
      s2 = create(:song, playlist: pl, playlist_id: pl.id)
      s3 = create(:song, playlist: pl, playlist_id: pl.id)
      pl_id = pl.id
      pl.destroy
      pl2 = create(:playlist)
      s4 = create(:song, playlist: pl2, playlist_id: pl2.id)
      s5 = create(:song, playlist: pl2, playlist_id: pl2.id)

      expect(Playlist.where(id: pl2.id)).to exist
      expect(pl2.songs).to include(s4,s5)
      expect(Playlist.where(id: pl_id)).not_to exist
      expect(Song.where(playlist_id: pl_id)).not_to exist
    end
  end
end
