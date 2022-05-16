require 'rails_helper'
require "bullet"

RSpec.describe 'Friendship Integration Tests', type: :system do

  let(:user_1) { FactoryBot.create(:user) }
  let(:user_2) { FactoryBot.create(:user) }

  before(:each) do 
    login_as(user_2) 
    login_as(user_1, :scope => :user) 
  end

  it 'Verifies friendship creation upon friend request acceptance' do
    visit users_path
    click_on user_2.username
    click_on 'Request Friendship'
    click_on "Sign Out"
    login_as(user_2, :scope => :user)

    visit friendship_requests_path
    click_on "Accept"
    visit friendships_path

    expect(page).to have_content("#{user_1.username}")
  end

  it 'Verifies friendship deletion upon friend acceptance and subsequent removal' do
    visit users_path
    click_on user_2.username
    click_on 'Request Friendship'
    click_on "Sign Out"
    login_as(user_2, :scope => :user)
    visit friendship_requests_path
    click_on "Accept"
    visit friendships_path

    click_on "Remove Friendship"
    page.accept_alert
    visit friendships_path

    expect(page).not_to have_content("#{user_1.username}")
  end

end
