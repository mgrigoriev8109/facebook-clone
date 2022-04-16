# spec/features/create_city_spec.rb

require 'rails_helper'

RSpec.describe 'Creating a friendship', type: :feature do
  before :each do
    User.create(username: "bob", email: "bob@gmail.com", password: "bobbob")
    User.create(username: "joe", email: "joe@gmail.com", password: "joejoe")
  end

  scenario 'valid inputs' do
    visit new_user_session_path
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in 'Password', with: 'bobbob'
    click_on 'Log In'
    visit users_path
    click_on 'joe'
    click_on 'Request Friendship'
    visit friendships_path
    expect(page).to have_content('joe')
  end
end
