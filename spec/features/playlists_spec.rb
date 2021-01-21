require 'rails_helper'

RSpec.feature 'Playlists' do

  before do
    login(create(:user))
  end

  scenario 'create playlist' do
    visit root_path
    click_on "New Playlist"
    pl_name = SecureRandom.hex(4)
    fill_in "Name", with: pl_name
    click_on "Create"
    expect(page).to have_content("Playlist successfully created")
    expect(page).to have_content("No Songs yet")
    expect(page).to have_content(pl_name)
    pl_id = Playlist.where(name: pl_name).first.id
    expect(current_path).to eq("/playlists/#{pl_id}")
  end

  scenario 'edit playlist' do
    click_on "New Playlist"
    pl_name = SecureRandom.hex(4)
    fill_in "Name", with: pl_name
    click_on "Create"
    pl_id = Playlist.where(name: pl_name).first.id
    page.find_by_id("edit_pl_#{pl_id}").click
    expect(current_path).to eq("/playlists/#{pl_id}/edit")
    pl_name_new = SecureRandom.hex(4)
    within("#editPlaylist") do
      fill_in 'Name', with: pl_name_new
      click_on "Update"
    end
    expect(page).to have_content("Playlist successfully updated")
    expect(current_path).to eq("/playlists/#{pl_id}")
    expect(Playlist.find(pl_id).name).not_to eq(pl_name)
    expect(Playlist.find(pl_id).name).to eq(pl_name_new)
  end

  scenario 'delete playlist' do
    click_on "New Playlist"
    pl_name = SecureRandom.hex(4)
    fill_in "Name", with: pl_name
    click_on "Create"
    page.find_by_id("delete_pl_#{Playlist.where(name: pl_name).first.id}").click
    expect(page).to have_content("Playlist deleted successfully")
    expect(Playlist.where(name: pl_name)).not_to exist
  end
end