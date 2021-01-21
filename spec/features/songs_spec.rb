require 'rails_helper'

RSpec.feature 'Songs' do


  scenario 'Add Song to Playlist' do
    user = create(:user)
    login(user)
    pl = create(:playlist, user: user)
    visit root_path
    click_on "#{pl.name}"
    click_on "Add Song"
    within '#songModal' do
      fill_in "yid_textfield", with: "https://www.youtube.com/watch?v=bwmSjveL3Lc"
      click_on "Add song"
    end
    expect(page).to have_content("Song successfully added")
    expect(page).to have_content("BLACKPINK")
    expect(current_path).to eq("/playlists/#{pl.id}")
  end

  scenario 'edit song name/start/end' do
    user = create(:user)
    login(user)
    pl = create(:playlist, user: user)
    visit "/"
    click_on "#{pl.name}"
    click_on "Add Song"
    within '#songModal' do
      fill_in "yid_textfield", with: "https://www.youtube.com/watch?v=bwmSjveL3Lc"
      click_on "Add song"
    end
    expect(page).to have_content("Song successfully added")
    expect(page).to have_content("BLACKPINK")
    expect(current_path).to eq("/playlists/#{pl.id}")
    song = Song.where(playlist: pl).first
    page.find_by_id("edit_song_#{song.id}").click
    expect(current_path).to eq("/songs/#{song.id}/edit")
    song_new_name = SecureRandom.hex(4)
    within "#songEdit" do
      fill_in "name", with: song_new_name
      fill_in "startSeconds", with: "00:10"
      fill_in "endSeconds", with: "00:11"
      click_on "Update"
    end
    expect(current_path).to eq("/playlists/#{pl.id}")
    expect(page).to have_content('Song updated')
    expect(Song.find(song.id).name).not_to eq("BLACKPINK - '붐바야'(BOOMBAYAH) M/V")
    expect(Song.find(song.id).name).to eq(song_new_name)
  end

  scenario 'delete song' do
    user = create(:user)
    login(user)
    pl = create(:playlist, user: user)
    visit "/"
    click_on "#{pl.name}"
    click_on "Add Song"
    within '#songModal' do
      fill_in "yid_textfield", with: "https://www.youtube.com/watch?v=bwmSjveL3Lc"
      click_on "Add song"
    end
    expect(page).to have_content("Song successfully added")
    expect(page).to have_content("BLACKPINK")
    expect(current_path).to eq("/playlists/#{pl.id}")
    song = Song.where(playlist: pl).first
    page.find_by_id("delete_song_#{song.id}").click
    expect(current_path).to eq("/playlists/#{pl.id}")
    expect(page).to have_content('Song deleted')
    expect(Song.where(id: song.id)).not_to exist
  end
end