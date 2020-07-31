class DriversController < ApplicationController

  def check_punctuation_form;end

  def track_request_form;end

  def check_punctuation
    @message = driver_service.check_punctuation
  end

  def track_request
    @message = driver_service.track_request
  end

  def driver_service
    DriversService.new(drivers_params)
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
