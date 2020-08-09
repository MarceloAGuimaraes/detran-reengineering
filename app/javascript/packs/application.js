// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require('jquery')
require('jquery-ui')
require('jquery-tooltip/jquery.tooltip')
require("bootstrap-material-design")
require('packs/material-dashboard')
require('@fortawesome/fontawesome-free')
require('bootstrap-select')
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

$(document).ready(function(){
  $('.datepicker').datepicker({ 
    format: 'dd-mm-yy',
    Altformat: 'dd-mm-yy',
    dateFormat: 'dd/mm/yy'
  });
  $('img-news-0', 'img-news-1', 'img-news-2').off('click');
  $('img-news-0', 'img-news-1', 'img-news-2').on('click', function(){
    window.open(`https://www.detran.mg.gov.br`);
  });
  $(".selectpicker").selectpicker({
    showIcon: true,
    showSubtext: false,
    noneSelectedText: "Selecione um serviço"
  });
})
