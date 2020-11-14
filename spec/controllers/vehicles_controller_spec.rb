require 'rails_helper'

RSpec.describe VehiclesController, type: :controller do
  include Devise::Test::ControllerHelpers
  describe 'GET' do

    it 'negative_certificate_form' do
      get :negative_certificate_form
      expect(response).to render_template('vehicles/negative_certificate_form')
    end

    it 'unlicensed_form' do
      get :unlicensed_form
      expect(response).to render_template('vehicles/unlicensed_form')
    end
  end
end
