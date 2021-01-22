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
require 'rails_helper'

RSpec.describe Song, type: :model do
  describe "#valid?" do

    it "is valid if the factory is used" do
      song = create(:song)
      expect(song).to be_valid
    end

    it "is invalid if startSeconds lies behind endSeconds" do
      song = create(:song)
      song.endSeconds = 40
      song.startSeconds = 50
      expect(song).to be_invalid
    end

    it "is invalid if endSeconds lies behind songDuration" do
      song = create(:song)
      song.endSeconds = 101
      expect(song).to be_invalid
    end

    it "is invalid if the name is too short" do
      song = create(:song)
      song.name = ""
      expect(song).to be_invalid
    end

    it "is invalid if it does not belong to playlist" do
      song = create(:song)
      song.playlist_id = nil
      expect(song).to be_invalid
    end
  end
end
