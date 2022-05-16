require 'rails_helper'
require "bullet"

RSpec.describe "Like Integration Tests", type: :system do
  let(:user_1) { FactoryBot.create(:user) }
  let(:user_2) { FactoryBot.create(:user) }
  let(:user_3) { FactoryBot.create(:user) }

  before(:each) do 
    login_as(user_1) 
    login_as(user_2, :scope => :user) 
    login_as(user_3, :scope => :user) 
  end

  it 'Viewing a like by user_2 of user_1s post' do
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
    click_on "Like"

    expect(page).to have_content("Liked by:\n#{user_2.username}")
  end

  it 'Viewing a like by user_3 of user_1s comment' do
    login_as(user_1) 
    visit root_path
    fill_in 'post[body]', with: "Here is a post by #{user_1.username}."
    click_on 'Submit'
    fill_in 'comment[body]', with: "Here is a comment by #{user_1.username}."
    within(".comment") do
      click_on("Submit")
    end
    visit users_path
    click_on user_3.username
    click_on 'Request Friendship'
    click_on "Sign Out"

    login_as(user_3, :scope => :user)
    visit friendship_requests_path
    click_on "Accept"
    visit root_path
    within(".made-comment") do
      click_on("Like")
    end
    expect(page).to have_content("Liked by:\n#{user_3.username}")
  end
end
