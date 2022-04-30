require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe 'Friendship Integration Tests', type: :system do
  before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean  
  end

  it 'Verifies a sent friendship request' do
    user_1 = FactoryBot.create(:user, email: '1@gmail.com', username: 'user_1')
    user_2 = FactoryBot.create(:user, email: '2@gmail.com', username: 'user_2')
    login_as(user_1, :scope => :user) 

    visit users_path
    click_on 'user_2'
    click_on 'Request Friendship'
    visit friendship_requests_path

    expect(page).to have_content('user_2')
  end

  it 'Verifies a received friendship request' do
    user_1 = FactoryBot.create(:user, email: '1@gmail.com', username: 'user_1')
    user_2 = FactoryBot.create(:user, email: '2@gmail.com', username: 'user_2')
    login_as(user_1, :scope => :user) 
    
    visit users_path
    click_on 'user_2'
    click_on 'Request Friendship'
    click_on "Sign Out"
    login_as(user_2, :scope => :user)
    visit friendship_requests_path

    expect(page).to have_content('user_1')
  end
end
