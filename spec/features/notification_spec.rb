require 'rails_helper'
require "bullet"

RSpec.describe 'Notification Integration Tests', type: :system do

  let(:user_1) { FactoryBot.create(:user) }
  let(:user_2) { FactoryBot.create(:user) }

  before(:each) do 
    login_as(user_2) 
    login_as(user_1, :scope => :user) 
  end

  it 'Verifies notification creation upon friend request creation' do
    visit users_path
    click_on user_2.username
    click_on 'Request Friendship'
    click_on "Sign Out"
    login_as(user_2, :scope => :user)

    visit notifications_path

    expect(page).to have_content("#{user_1.username} sent you a friendship request!")
  end

  it 'Verifies notification creation upon friendship creation' do
    visit users_path
    click_on user_2.username
    click_on 'Request Friendship'
    click_on "Sign Out"

    login_as(user_2, :scope => :user)
    visit friendship_requests_path
    click_on "Accept"
    click_on "Sign Out"

    login_as(user_1, :scope => :user)
    visit notifications_path

    expect(page).to have_content("#{user_2.username} accepted your friendship request!")
  end
end
