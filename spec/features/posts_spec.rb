require 'rails_helper'

RSpec.describe "Post Integration Tests", type: :system do
  before do
    login_as(FactoryBot.create(:user))
    visit posts_path
  end

  it 'valid inputs' do
    fill_in 'Body', with: 'Here is a test post.'
    click_on 'Submit Post'

    expect(page).to have_content('Here is a test post.')
  end
end
