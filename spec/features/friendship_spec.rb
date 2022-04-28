require 'rails_helper'

RSpec.describe 'Friendship Integration Tests', type: :system do
  before do
    FactoryBot.create(:user_two)
    login_as(FactoryBot.create(:user))
  end

  it 'Verifies a sent friendship request' do
    visit users_path
    click_on 'user_two'
    click_on 'Request Friendship'
    visit friendships_path

    expect(page).to have_content('Friendship Request Sent: user_two')
  end

  xit 'Verifies a received friendship request' do
    visit users_path
    click_on 'user_two'
    click_on 'Request Friendship'
    logout
    login_as(:user_two)
    visit friendships_path

    expect(page).to have_content('Friendship Request Received: user_one')
  end
end
