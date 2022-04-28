require 'rails_helper'

RSpec.describe "Post Integration Tests", type: :system do
  before do
    login_as(FactoryBot.create(:user))
  end

  it 'valid inputs' do
    visit root_path
    fill_in 'post[body]', with: 'Here is a test post.'
    click_on 'Create Post'

    expect(page).to have_content('Here is a test post.')
  end
end
