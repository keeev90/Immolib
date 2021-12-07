require 'rails_helper'

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'valid@email.com', 'password'

    expect(page).to have_content('Me déconnecter')
  end

  scenario 'with invalid email' do
    sign_up_with 'invalid_email', 'password'

    expect(page).to have_content('Se connecter')
  end

  scenario 'with blank password' do
    sign_up_with 'valid@email.com', ''

    expect(page).to have_content('Se connecter')
  end

  def sign_up_with(email, password)
    visit new_user_registration_path
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
    click_button "M'inscrire"
  end
end