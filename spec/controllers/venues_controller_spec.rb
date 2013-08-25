require 'spec_helper'

describe VenuesController do

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'edit_media'" do
    it "returns http success" do
      get 'edit_media'
      response.should be_success
    end
  end

  describe "GET 'edit_schedule'" do
    it "returns http success" do
      get 'edit_schedule'
      response.should be_success
    end
  end

end
