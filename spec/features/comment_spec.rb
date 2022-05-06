require 'rails_helper'

RSpec.describe "Comment Integration Tests", type: :system do
  let(:user_1) { FactoryBot.create(:user) }
  let(:user_2) { FactoryBot.create(:user) }
  let(:user_3) { FactoryBot.create(:user) }

  before(:each) do 
    login_as(user_1) 
    login_as(user_2, :scope => :user) 
    login_as(user_3, :scope => :user) 
  end

  it 'Logging in and creating posts by current user' do
    login_as(user_1) 
    visit root_path
    fill_in 'post[body]', with: 'Here is a post by current_user.'
    click_on 'Save Post'

    expect(page).to have_content('Here is a comment by current_user.')
  end
end
