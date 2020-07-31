class InfractionsController < ApplicationController
  def infraction_result
    # { by_plate: true, by_number: false, plate: 'AVB4444', number: nil, chassi: '3VWSA49M01MMM6699', renavam: '775559066'}
    @message = infraction_service.infraction_result
  end

  def infraction_result_form; end

  def assessment_defense
    # params = { by_doc: true, by_plate: false, by_defense_number: false, plate: nil, defense_number: nil, document_number: '11372170650' }
    @message = infraction_service.assessment_defense
  end

  def assessment_defense_form; end

  private

  def infraction_service
    InfractionsService.new(infractions_params.merge({by_plate: params[:by_plate].present? }))
  end

  def infractions_params
    params.require(:infractions).permit(
      :by_doc,
      :by_plate,
      :by_number,
      :by_defense_number,
      :plate,
      :number,
      :defense_number,
      :document_number,
      :chassi,
      :renavam
    )
  end
end