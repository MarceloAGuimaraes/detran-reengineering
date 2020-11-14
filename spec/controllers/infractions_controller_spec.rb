require 'rails_helper'

RSpec.describe InfractionsController, type: :controller do
  describe 'GET' do

    it 'assessment_defense_form' do
      get :assessment_defense_form
      expect(response).to render_template('infractions/assessment_defense_form')
    end

    it 'infraction_result_form' do
      get :infraction_result_form
      expect(response).to render_template('infractions/infraction_result_form')
    end
  end
end
