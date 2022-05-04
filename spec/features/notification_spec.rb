require 'rails_helper'
require "bullet"

RSpec.describe 'Notification Integration Tests', type: :system do

  let(:user_1) { FactoryBot.create(:user, email: '1@gmail.com', username: 'user_1') }
  let(:user_2) { FactoryBot.create(:user, email: '2@gmail.com', username: 'user_2') }

  before(:each) do 
    login_as(user_2) 
    login_as(user_1, :scope => :user) 
  end

  it 'Verifies notification creation upon friend request acceptance' do
    visit users_path
    click_on 'user_2'
    click_on 'Request Friendship'
    click_on "Sign Out"
    login_as(user_2, :scope => :user)

    visit notifications_path

    expect(page).to have_content('user_1 sent you a friendship request!')
  end
end
