require 'rails_helper'
require "bullet"

RSpec.describe "Comment Integration Tests", type: :system do
  let(:user_1) { FactoryBot.create(:user) }
  let(:user_2) { FactoryBot.create(:user) }
  let(:user_3) { FactoryBot.create(:user) }

  before(:each) do 
    login_as(user_1) 
    login_as(user_2, :scope => :user) 
    login_as(user_3, :scope => :user) 
  end

  it 'Logging in and creating a comment by current user' do
    login_as(user_1) 
    visit root_path
    fill_in 'post[body]', with: "Here is a post by #{user_1.username}."
    click_on 'Submit'
    fill_in 'comment[body]', with: "Here is a comment by #{user_1.username}."
    within(".comment") do
      click_on("Submit")
    end

    expect(page).to have_content("Here is a comment by #{user_1.username}.")
  end

  it 'Logging in and commenting on user_1 post by user_2' do
    login_as(user_1) 
    visit root_path
    fill_in 'post[body]', with: "Here is a post by #{user_1.username}."
    click_on 'Submit'
    visit users_path
    click_on user_2.username
    click_on 'Request Friendship'
    click_on "Sign Out"

    login_as(user_2, :scope => :user)
    visit friendship_requests_path
    click_on "Accept"
    visit root_path
    fill_in 'comment[body]', with: "Here is a comment by #{user_2.username}."
    within(".comment") do
      click_on("Submit")
    end

    expect(page).to have_content("Here is a comment by #{user_2.username}.")
  end
end
