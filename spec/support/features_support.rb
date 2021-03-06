
def sign_up(first_name, last_name, email, password, confirmation)
  visit '/users/sign_up'
  fill_in 'user[first_name]', with: first_name
  fill_in 'user[last_name]', with: last_name
  fill_in 'user[email]', with: email
  fill_in 'user[password]', with: password
  fill_in 'user[password_confirmation]', with: password
  click_button 'Sign up'
end

def sign_in(email, password)
  visit '/users/sign_in'
  fill_in 'user[email]', with: email
  fill_in 'user[password]', with: password
  click_button 'Log in'
end
