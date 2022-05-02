require 'rails_helper'
require 'database_cleaner/active_record'
require "bullet"

RSpec.describe 'Friendship Integration Tests', type: :system do

  let(:user_1) { FactoryBot.create(:user, email: '1@gmail.com', username: 'user_1') }
  let(:user_2) { FactoryBot.create(:user, email: '2@gmail.com', username: 'user_2') }

  before(:each) do 
    login_as(user_2) 
    login_as(user_1, :scope => :user) 
  end

  it 'Verifies a sent friendship request' do
    visit users_path
    click_on 'user_2'

    click_on 'Request Friendship'
    visit friendship_requests_path

    expect(page).to have_content('user_2')
  end

  it 'Verifies a received friendship request' do
    visit users_path
    click_on 'user_2'
    click_on 'Request Friendship'
    click_on "Sign Out"

    login_as(user_2, :scope => :user)
    visit friendship_requests_path

    expect(page).to have_content('user_1')
  end

  it 'Verifies deleting a friendship request' do
    visit users_path
    click_on 'user_2'
    click_on 'Request Friendship'

    visit friendship_requests_path
    click_on "Reject Request"
    page.accept_alert
    visit friendship_requests_path

    expect(page).not_to have_content('user_2')
  end

  it 'Verifies accepted new friend upon accepted friendship' do
    visit users_path
    click_on 'user_2'
    click_on 'Request Friendship'
    click_on "Sign Out"
    login_as(user_2, :scope => :user)

    visit friendship_requests_path
    click_on "Accept Friendship"
    visit friendships_path

    expect(page).to have_content('user_1')
  end

  it 'Verifies friendship request deletion upon friend acceptance' do
    visit users_path
    click_on 'user_2'
    click_on 'Request Friendship'
    click_on "Sign Out"
    login_as(user_2, :scope => :user)
    visit friendship_requests_path
    click_on "Accept Friendship"
    visit friendships_path

    click_on "Remove Friendship"
    page.accept_alert
    visit friendships_path

    expect(page).not_to have_content('user_1')
  end

end
