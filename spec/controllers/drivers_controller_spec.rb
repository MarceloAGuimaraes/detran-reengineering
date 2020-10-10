require 'rails_helper'

RSpec.describe DriversController, type: :controller do
  describe 'GET' do
    it 'check_punctuation_form' do
      get :check_punctuation_form
      expect(response).to render_template('drivers/check_punctuation_form')
    end

    it 'track_request_form' do
      get :track_request_form
      expect(response).to render_template('drivers/track_request_form')
    end
  end
end
