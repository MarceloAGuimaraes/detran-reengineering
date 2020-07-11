class VehiclesController < ApplicationController
  def unlicensed
    vehicle_service = VehiclesService.new({ placa: 'AVB4444', chassi: '3VWSA49M01MMM6699', renavam: '775559066'})
    @message = vehicle_service.unlicensed
  end

  def negative_certificate
    vehicle_service = VehiclesService.new({ selecionar_gerar_validar: 1, cpf: '752.367.840-85', nome: 'Ruan Roman Riquelme' })
    begin
      @cpf = vehicles_params[:cpf]
    rescue
      @cpf = '752.367.840-85'
    end
    @cpf = @cpf.remove('.', '-')
    @message = vehicle_service.negative_certificate
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