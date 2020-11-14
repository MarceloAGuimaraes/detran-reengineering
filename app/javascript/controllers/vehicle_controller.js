import { Controller } from "stimulus"
export default class VehicleController extends Controller {
    initialize(){
        $('#select-vehicle').off('change');
        $('#select-vehicle').on('change', function(){
            var selectedVehicleId = $('#select-vehicle').val();
            var vehicle = $('#select-vehicle').data('vehicles').find( function(veh) { return veh.id == Number(selectedVehicleId) })
            if(vehicle){
                $('.filter-option-inner-inner').text(vehicle.model);
                $('#vehicles_chassi').val(vehicle.chassi);
                $('#vehicles_placa').val(vehicle.plate);
                $('#vehicles_renavam').val(vehicle.renavam);
                $('.form-group.bmd-form-group').addClass('is-filled');
            }
        });
    }
}
