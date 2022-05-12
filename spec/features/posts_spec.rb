require 'rails_helper'

RSpec.describe "Post Integration Tests", type: :system do
  let(:user_1) { FactoryBot.create(:user, email: '1@gmail.com', username: 'user_1') }
  let(:user_2) { FactoryBot.create(:user, email: '2@gmail.com', username: 'user_2') }
  let(:user_3) { FactoryBot.create(:user, email: '3@gmail.com', username: 'user_3') }

  before(:each) do 
    login_as(user_1) 
    login_as(user_2, :scope => :user) 
    login_as(user_3, :scope => :user) 
  end

  it 'Logging in and creating posts by current user' do
    login_as(user_1) 
    visit root_path
    fill_in 'post[body]', with: 'Here is a post by current_user.'
    click_on 'Submit'

    expect(page).to have_content('Here is a post by current_user.')
  end

  it 'Logging in and viewing post made by friendship_recipient of current users friendship' do
    login_as(user_2, :scope => :user) 
    visit root_path
    fill_in 'post[body]', with: 'Here is a post by the person who sent the friendship request.'
    click_on 'Submit'
    visit users_path
    click_on user_1.username
    click_on 'Request Friendship'
    click_on "Sign Out"

    login_as(user_1, :scope => :user)
    visit friendship_requests_path
    click_on "Accept"
    visit root_path
    #user_2 is now the 'friendship_recipient', since user_1 provided the friendship by accepting it

    expect(page).to have_content('Here is a post by the person who sent the friendship request.')
  end

  it 'Logging in and viewing post made by friendship_provider of current users friendship' do

    login_as(user_1)
    visit users_path
    click_on user_3.username
    click_on 'Request Friendship'
    click_on "Sign Out"

    login_as(user_3, :scope => :user)
    visit friendship_requests_path
    click_on "Accept"
    visit root_path
    fill_in 'post[body]', with: 'Here is a post by the person who accepted the users friendship request.'
    click_on 'Submit'
    click_on "Sign Out"
    
    login_as(user_1, :scope => :user)
    visit root_path
    #user_3 is now the 'friendship_provider', since user_2 provided the friendship by accepting it

    expect(page).to have_content('Here is a post by the person who accepted the users friendship request.')
  end
end
