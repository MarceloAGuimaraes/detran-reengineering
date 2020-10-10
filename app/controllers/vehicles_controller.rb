class VehiclesController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create destroy]
  before_action 
  def index
    @vehicles = current_user.vehicles
  end

  def new
    @vehicle = Vehicle.new
  end

  def destroy
    @vehicle = Vehicle.find(params[:id])
    @vehicles = current_user.vehicles
    respond_to do |format|
      if @vehicle.destroy
        flash[:error] = 'Deleted'
        format.html { redirect_to request.referer, status: 303  }
        format.js { redirect_to request.referer, status: 303  }
      end
    end
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

  def unlicensed_form
    serializar = proc { |x| x.serializable_hash.except('model', 'color', 'user_id') }
    @vehiclesJSON = current_user.vehicles.each(&serializar).to_json if current_user.present?
  end

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