#require 'spec_helper'
#
#feature 'User signin/signup' do
#
#  before do
#    FactoryGirl.create(:user)
#  end
#
#  scenario 'user signin to his/her account' do
#    visit new_user_session_path
#
#    fill_in 'Email', with: 'nflores@appsource.biz'
#    fill_in 'Password', with: 'password'
#    click_button 'Sign in'
#
#    expect(page).to have_content("Signed in successfully.")
#  end
#
#end
