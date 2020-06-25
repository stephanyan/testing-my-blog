require 'rails_helper'

RSpec.describe 'Sign up feature', type: :feature do
  let(:user) { FactoryBot.build(:user) }

  it 'should be valid with valid email, first_name, last_name, password and password_confirmation' do
    sign_up_with user.email, user.first_name, user.last_name, user.password, user.password_confirmation
    expect(page).to have_content('Sign out')
  end

  context '#email' do
    it 'should be valid with valid email' do
      sign_up_with user.email, user.first_name, user.last_name, user.password, user.password_confirmation
      expect(page).to have_content('Sign out')
    end

    it 'should not be valid with blank email' do
      sign_up_with '', user.first_name, user.last_name, user.password, user.password_confirmation
      expect(page).to have_content("Email can't be blank")
    end

    it 'should not be valid without email' do
      sign_up_with nil, user.first_name, user.last_name, user.password, user.password_confirmation
      expect(page).to have_content("Email can't be blank")
    end
  end

  context '#first_name' do
    it 'should be valid with valid first_name' do
      sign_up_with user.email, user.first_name, user.last_name, user.password, user.password_confirmation
      expect(page).to have_content('Sign out')
    end

    it 'should not be valid with blank first_name' do
      sign_up_with user.email, '', user.last_name, user.password, user.password_confirmation
      expect(page).to have_content("First name can't be blank")
    end

    it 'should not be valid without first_name' do
      sign_up_with user.email, nil, user.last_name, user.password, user.password_confirmation
      expect(page).to have_content("First name can't be blank")
    end
  end

  context '#last_name' do
    it 'should be valid with valid last_name' do
      sign_up_with user.email, user.first_name, user.last_name, user.password, user.password_confirmation
      expect(page).to have_content('Sign out')
    end

    it 'should not be valid with blank last_name' do
      sign_up_with user.email, user.first_name, '', user.password, user.password_confirmation
      expect(page).to have_content("Last name can't be blank")
    end

    it 'should not be valid without last_name' do
      sign_up_with user.email, user.first_name, nil, user.password, user.password_confirmation
      expect(page).to have_content("Last name can't be blank")
    end
  end

  context '#password' do
    it 'should be valid with valid password' do
      sign_up_with user.email, user.first_name, user.last_name, user.password, user.password_confirmation
      expect(page).to have_content('Sign out')
    end

    it 'should not be valid with blank password' do
      sign_up_with user.email, user.first_name, user.last_name, '', user.password_confirmation
      expect(page).to have_content("Password can't be blank")
    end

    it 'should not be valid without password' do
      sign_up_with user.email, user.first_name, user.last_name, nil, user.password_confirmation
      expect(page).to have_content("Password can't be blank")
    end
  end

  context '#password_confirmation' do
    it 'should be valid with valid password_confirmation' do
      sign_up_with user.email, user.first_name, user.last_name, user.password, user.password_confirmation
      expect(page).to have_content('Sign out')
    end

    it 'should not be valid with blank password_confirmation' do
      sign_up_with user.email, user.first_name, user.last_name, user.password, ''
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    it 'should not be valid without password_confirmation' do
      sign_up_with user.email, user.first_name, user.last_name, user.password, nil
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end

  def sign_up_with(email, first_name, last_name, password, password_confirmation)
    visit new_user_registration_path
    within('form') do
      fill_in 'user_email', with: email
      fill_in 'user_first_name', with: first_name
      fill_in 'user_last_name', with: last_name
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password_confirmation
    end
    click_button 'Sign up'
  end
end
