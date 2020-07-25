class VehiclesController < ApplicationController
  def unlicensed
    @message = vehicle_service.unlicensed
  end

  def unlicensed_form; end

  def negative_certificate_form; end

  def negative_certificate
    @message = vehicle_service.negative_certificate
  end

  def vehicle_service
    VehiclesService.new(vehicles_params)
  end

  private

  def vehicles_params
    params.require(:vehicles).permit(
      :placa,
      :chassi,
      :renavam,
      :cpf,
      :selecionar_gerar_validar,
      :nome
    )
  end
end


# @params = { selecionar_gerar_validar: 1, cpf: '752.367.840-85', nome: 'Ruan Roman Riquelme' }
# { placa: 'AVB4444', chassi: '3VWSA49M01MMM6699', renavam: '775559066'}