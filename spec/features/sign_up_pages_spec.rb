require 'rails_helper'

RSpec.feature "SignUpPages", type: :feature do
  # going to sign up page
  context 'Going to Sign up page' do
   Steps 'Sign up' do
     Given 'I am on the sign up page' do
       visit '/users/sign_up'
     end
     Then 'I can see a sign up form' do
       expect(page).to have_content('Sign up')
     end
   end
 end
 # filling up sign up form
  context 'Signing up' do
    Steps 'Sign up' do
      Given 'That I can see the sign up form' do
        visit '/users/sign_up'
      end
      Then 'I can fill in the form' do
        fill_in 'user_first_name', with: 'Taylor'
        fill_in 'user_last_name', with: 'swift'
        fill_in 'user_email', with: 'bobby@email.com'
        fill_in 'user_password', with: 'test123'
        fill_in 'user_password_confirmation', with: 'test123'
        click_button 'Sign up'
        expect(page).to have_content('You have signed up successfully')
      end
      Then 'I can log out' do
        click_link 'Taylor'
        click_link 'Logout'
        expect(page).to have_content('Signed out successfully')
      end
      Then 'I can sign in' do
        click_link 'Login'
        fill_in 'user_email', with: 'bobby@email.com'
        fill_in 'user_password', with: 'test123'
        click_button 'Log in'

      end
      Then 'I can log out' do
        click_link 'Logout'
        expect(page).to have_content('Signed out successfully')
      end
    end
  end
end
