class VehiclesController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  def index
    @vehicles = current_user.vehicles
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicles_params(:vehicle))
    @vehicle.user = current_user
    if @vehicle.save!
      @vehicles = current_user.vehicles
      render 'index'
    else
      render 'new'
    end
  end

  def unlicensed
    @message = vehicle_service.unlicensed
  end

  def unlicensed_form; end

  def negative_certificate_form; end

  def negative_certificate
    @message = vehicle_service.negative_certificate
    @cpf = vehicle_service.cpf
  end

  def vehicle_service
    VehiclesService.new(vehicles_params(:vehicles))
  end

  private

  def vehicles_params(named)
    params.require(named).permit(
      :placa,
      :plate,
      :model,
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