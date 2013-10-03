require 'spec_helper'

def fill_registration_params name, password, confirmation, role = 'Fan'
  fill_in 'registration_username', with: name
  fill_in 'registration_password', with: password
  fill_in 'registration_password_confirmation', with: confirmation
  select(role, from: 'registration_registrateable_type')
end

def pass_step_one_as role
  visit new_registration_path
  fill_registration_params Faker::Internet.email, '123456', '123456', role
  click_on 'Next step'
end

describe 'Registration process', :type => :feature do

  def should_finish_registration user_info
    page.should have_content('Your registration is complete')
    user_info.each { |info| page.should have_content(info) }
  end

  describe 'First common step' do
    it 'fails first step if username is occupied or password doesn''t match' do
      Registration.make! username: 'Albert', registrateable: Fan.make!
      visit new_registration_path
      fill_registration_params 'Albert', '0123456', '123456'
      click_on 'Next step'
      page.should have_content("doesn't match")
      page.should have_content('has already been taken')
    end

    it 'passes first registration step, redirecting to specific step' do
      pass_step_one_as 'Fan'
      page.should have_content('Log out')
    end
  end

  context 'Band registration' do

    it 'goes through all other steps' do
      pass_step_one_as 'Band'
      band_info = ['A famous band', 'Some good description']
      fill_in 'band_name', with: band_info[0]
      fill_in 'band_description', with: band_info[1]
      click_on 'Done'
      page.should have_content('Upload an image')
      page.should have_content('Upload a song')
      click_on 'Done'
      should_finish_registration band_info
    end

  end

  context 'Fan registration' do

    it 'goes through all other steps', :js => true do
      pending 'JS driver doesnt work'
      #pass_step_one_as 'Fan'
      #should_have_input_fields %w(Avatar Name Friends Favorite bands venues)
      #click_on 'Done'
      #should_finish_registration
    end

  end

  context 'Venue registration' do

    it 'goes through all other steps' do
      pass_step_one_as 'Venue'
      venue_info = ['A good place', 'Washington D.C.', 'Some description']
      fill_in 'venue_name', with: venue_info[0]
      fill_in 'venue_address', with: venue_info[1]
      fill_in 'venue_description', with: venue_info[2]
      click_on 'Done'
      click_on 'Done'
      should_finish_registration venue_info
    end

  end

end

describe 'Unfinished registration behaviour' do

  def current_venue_step_should_be step
    case step
      when 'edit'
        page.should have_content('Name')
        page.should have_content('Address')
        page.should have_content('Description')
      when 'edit media'
        page.should have_content('Upload')
        page.should have_content('Image')
        page.should have_content('Video')
        page.should have_content('Menu')
    end
  end

  def current_band_step_should_be step
    case step
      when 'edit'
        page.should have_content('Name')
        page.should have_content('Genre')
        page.should have_content('Description')
        page.should have_content('links')
      when 'edit media'
        page.should have_content('Upload')
        page.should have_content('image')
        page.should have_content('song')
    end
  end

  def profile_should_not_be_ready
    click_on 'my_profile'
    page.should have_content('Please fill more information about')
  end

  def profile_should_be_ready
    page.should have_content('Your registration is complete')
  end

  def skip_registration_on_each_step role
    logout
    pass_step_one_as role
    profile_should_not_be_ready
    click_on 'skip_registration'
    profile_should_be_ready

    logout
    pass_step_one_as role
    click_on 'Done'
    profile_should_not_be_ready
    click_on 'skip_registration'
    profile_should_be_ready
  end


  context 'Venue' do
    it 'redirects to current registration step when trying to view uncompleted profile' do
      pass_step_one_as 'Venue'
      profile_should_not_be_ready
      current_venue_step_should_be 'edit'
      click_on 'Done'
      profile_should_not_be_ready
      current_venue_step_should_be 'edit_media'
      click_on 'Done'
      profile_should_be_ready
    end

    it 'is possible to skip registration steps' do
      skip_registration_on_each_step 'Venue'
    end
  end

  context 'Band' do
    it 'redirects to current registration step when trying to view uncompleted profile' do
      pass_step_one_as 'Band'
      profile_should_not_be_ready
      current_band_step_should_be 'edit'
      click_on 'Done'
      profile_should_not_be_ready
      current_band_step_should_be 'edit media'
      click_on 'Done'
      profile_should_be_ready
    end

    it 'is possible to skip registration steps' do
      skip_registration_on_each_step 'Band'
    end
  end

end