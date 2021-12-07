describe "Signin process", type: :feature do
  before :each do
    User.create(email: 'user@example.com', password: 'password')
  end

  it "signs me in" do
    visit new_user_session_path

    fill_in 'user_email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'

    click_button 'Me connecter'

    expect(page).to have_content 'Me déconnecter'
  end
end