class DriversController < ApplicationController

  def check_punctuation_form;end

  def check_punctuation
    driver_service = DriversService.new(params[:check_pontuaction])
    @message = driver_service.check_punctuation
  end

  def track_request
    driver_service = DriversService.new({ service_type: 14, birth_date: '25/02/1999', cpf: '11372170650'})
    @message = driver_service.track_request
  end

  private

  def drivers_params
    params.require(:drivers).permit(
      :service_type,
      :birth_date,
      :cpf,
      :cnh_type,
      :cnh_number,
      :first_cnh_date
    )
  end
end
