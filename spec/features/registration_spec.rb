require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with:'password'
    fill_in :user_password_confirmation, with:'password'
    
    click_button 'Create New User'

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome, User One!")
  end 

  it 'does not create a user if email isnt unique' do 
    User.create(name: 'User One', email: 'notunique@example.com', password: "password", password_confirmation: "password")

    visit register_path
    
    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'notunique@example.com'
    fill_in :user_password, with:'password1'
    fill_in :user_password_confirmation, with:'password1'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end
  
  it 'does not create a user if name is missing' do 

    visit register_path
    
    fill_in :user_name, with: ''
    fill_in :user_email, with:'user@example.com'
    fill_in :user_password, with:'password'
    fill_in :user_password_confirmation, with:'password'
    click_button 'Create New User'
    
    expect(current_path).to eq(register_path)
    expect(page).to have_content("Name can't be blank")
  end
  
  it 'does not create a user if email is missing' do 

    visit register_path
    
    fill_in :user_name, with: 'User'
    fill_in :user_email, with:''
    fill_in :user_password, with:'password'
    fill_in :user_password_confirmation, with:'password'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email can't be blank")
  end
  
  it 'does not create a user if password and confirmation dont match' do 

    visit register_path
    
    fill_in :user_name, with: 'User'
    fill_in :user_email, with:'user@example.com'
    fill_in :user_password, with:'password1'
    fill_in :user_password_confirmation, with:'password'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
