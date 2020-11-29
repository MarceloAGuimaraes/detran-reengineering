$(document).ready(function (){
    $('.link-generate-pdf').off('click');
    $('.link-generate-pdf').on('click', function (){
        var cpf = $('.link-generate-pdf').data('cpf');
        window.open(`https://acesso.detran.mg.gov.br/veiculos/certidoes/certidao-negativa-de-propriedade/-/exibe_certidao_negativa_formato_pdf/${cpf}/`);
    });
});