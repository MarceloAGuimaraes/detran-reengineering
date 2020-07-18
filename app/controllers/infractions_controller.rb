class InfractionsController < ApplicationController
  def infraction_result
    infraction_service = InfractionsService.new({ by_plate: true, by_number: false, plate: 'AVB4444', number: nil, chassi: '3VWSA49M01MMM6699', renavam: '775559066'})
    @message = infraction_service.infraction_result
  end

  def assessment_defense
    # params = { by_doc: true, by_plate: false, by_defense_number: false, plate: nil, defense_number: nil, document_number: '11372170650' }
    params = { by_doc: true, by_plate: false, by_defense_number: false, plate: nil, defense_number: nil, document_number: '11372170650' }
    infraction_service = InfractionsService.new(params)
    @message = infraction_service.assessment_defense
  end
end