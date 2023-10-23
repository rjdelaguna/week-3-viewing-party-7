require 'rails_helper'

RSpec.describe "Login page" do
  it "can log in with valid credentials" do
    user = User.create(name: "User", email: "user@test.com", password: "password")

    visit root_path

    click_on "Login"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Welcome, #{user.name}")
  end

  it "cannot log in with incorrect email" do
    user = User.create(name: "User", email: "user@test.com", password: "password")

    visit login_path
    
    fill_in :email, with: "this@email.com"
    fill_in :password, with: user.password
  
    click_on "Log In"
  
    expect(current_path).to eq(login_path)
  
    expect(page).to have_content("Sorry, your credentials are bad.")
  end
  
  it "cannot log in with incorrect password" do
    user = User.create(name: "User", email: "user@test.com", password: "password")

    visit login_path
    
    fill_in :email, with: user.email
    fill_in :password, with: "password1"
  
    click_on "Log In"
  
    expect(current_path).to eq(login_path)
  
    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end