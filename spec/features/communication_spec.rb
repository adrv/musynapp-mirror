require 'spec_helper'
require 'rake'


describe 'Messaging', :type => :feature do

  def send_message subject, body
    click_on 'sendMessage'
    fill_in 'messageSubject', with: subject
    fill_in 'messageBody', with: body
    click_on 'Send'
  end

  before(:all) do
    DatabaseCleaner.clean
    generate_users
  end

  let(:venue) { Venue.first }
  let(:band) { Band.first }

  it 'sends a message and the opposite side receives it', :js => true do
    pending 'JS driver doesnt work'
    login 'band'
    visit venue_path(venue)
    send_message 'A subject', 'A long descriptive body'
    page.should have_content('message is sent')

    logout
    login 'venue'
    visit conversations_path
    page.should have_content('A subject')
    click_on 'A subject'
    page.should have_content('A long descriptive body')
  end

end



describe 'Requests' do

  def link_to_requested_should_be_shown
    visit show_path(show)
    page.should have_selector("a[href='#{polymorphic_path(requester)}']")
  end

  def address_should_be_shown
    logout
    login 'fan'
    visit show_path(show)
    page.should have_content(show.address)
  end

  def address_should_not_be_shown
    logout
    login 'fan'
    visit show_path(show)
    page.should_not have_content(show.address)
    page.should have_content('Request address')
  end

  def link_to_requested_should_not_be_shown
    visit show_path(show)
    page.should_not have_selector("a[href='#{polymorphic_path(requested)}']")
  end

  before(:all) do
    DatabaseCleaner.clean
    generate_users
  end

  def send_address_request
    login 'fan'
    visit show_path(show)
    #save_and_open_page
    click_on 'Request address'
  end

  context 'Show approving requests between Venue/Band' do

    let(:show) { Show.make! band: Band.first, venue: Venue.first }
    let(:requester) { show.requester }
    let(:requested) { show.requested }


    it "doesn't show the link to requested side unless approved" do
      visit show_path(show)
      page.should_not have_selector("a[href='#{polymorphic_path(requested)}']")
    end

    it 'automatically sends a request and tracks this action in requests box' do
      login requester.registration.username
      visit requests_path
      page.should have_content('Requests sent')
      page.should have_content(requested.name)
    end

    it 'accepts request and the link to requested side is made available within Show page' do
      login requested.registration.username
      visit requests_path
      within('.table'){ click_on 'accept' }
      page.should have_content('You accepted request')
      page.should_not have_content('Requests received') # Check that there is no requests anymore
      link_to_requested_should_be_shown
    end

    it 'denies request' do
      login requested.registration.username
      visit requests_path
      within('.table'){ click_on 'reject' }
      page.should have_content('You rejected request')
      link_to_requested_should_not_be_shown
    end


  end

  context 'Fan address request to Band' do

    let(:show) { Show.make! band: Band.first, venue: Venue.first, private: true }


    it 'sends address request to the band' do
      send_address_request
      page.should have_content('Your request is sent')
    end

    it 'accepts request' do
      send_address_request
      logout
      login show.band.registration.username
      visit requests_path
      all(:css, ".accept-request").last.click
      address_should_be_shown
    end

    it 'denies request' do
      send_address_request
      logout
      login show.band.registration.username
      visit requests_path
      all(:css, ".reject-request").last.click
      address_should_not_be_shown
    end

  end

  context 'Multiple requests management' do

    let(:show) { Show.make! band: Band.first, venue: Venue.first, private: true }
    let(:requester) { show.requester }
    let(:requested) { show.requested }

    it 'accepts multiple requests of different types' do
      send_address_request
      logout
      login show.requested.registration.username # Assume that the requested side ‰‰is also a Band
      visit requests_path
      #save_and_open_page
      find(:css, "#request_ids_[value='#{Request.first.id}']").set(true)
      find(:css, "#request_ids_[value='#{Request.all[1].id}']").set(true)
      click_on 'accept_all'
      page.should have_content('Successfully accepted all selected requests')
      page.should_not have_content('Requests received') # Check that there is no requests anymore
      address_should_be_shown
      link_to_requested_should_be_shown
    end

    it 'rejects multiple requests of different types' do
      send_address_request
      logout
      login show.requested.registration.username
      visit requests_path
      find(:css, "#request_ids_[value='#{Request.first.id}']").set(true)
      find(:css, "#request_ids_[value='#{Request.all[1].id}']").set(true)
      click_on 'reject_all'
      page.should have_content('Successfully rejected all selected requests')
      page.should_not have_content('Requests received')
      address_should_not_be_shown
      link_to_requested_should_not_be_shown
    end

  end
end
