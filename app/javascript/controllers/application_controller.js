import { Controller } from "stimulus"
export default class ApplicationController extends Controller {
    initialize(){
        var DETRAN_HOST = 'https://www.detran.mg.gov.br'
        $('.datepicker').datepicker({ 
          format: 'dd-mm-yy',
          Altformat: 'dd-mm-yy',
          dateFormat: 'dd/mm/yy'
        });
        $('.carousel-item img').off('click');
        $('.carousel-item img').on('click', function(){
          window.open(`https://www.detran.mg.gov.br`);
        });
        $('.noticias-alert').css('cursor', 'pointer');
        $('.noticias-alert').off('click');
        $('.noticias-alert').on('click', function(){
          window.open(`${DETRAN_HOST}${$(this).data('link')}`);
        });
        $(".selectpicker").selectpicker({
          showIcon: true,
          showSubtext: false,
          noneSelectedText: "Selecione"
        });
    
        $('#close').off('click');
        $('#close').on('click', function(){
          $(this).parents('#record-modal').removeClass('active');
        });
        $('.simple_form.vehicles #myInfos').off('click');
        $('.simple_form.vehicles #myInfos').on('click', function(){
          $('#vehicles_nome').val($(this).data('nome'));
          $('#vehicles_cpf').val($(this).data('cpf'));
        });
    }
}
