// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require plugins/jquery
//= require rails-ujs
//= require jquery.turbolinks
//= require plugins/bootstrap.min
//= require plugins/adminlte.min
//= require toastr_rails
//= require plugins/bootstrap-datepicker.min
//= require plugins/bootstrap-datepicker.pt-BR
//= require plugins/jquery.inputmask
//= require plugins/jquery.inputmask.date.extensions
//= require plugins/jquery.maskMoney
//= require plugins/moment.min
//= require plugins/moment-with-locales.min
//= require_tree .

document.addEventListener('DOMContentLoaded', () => {
  //Date picker
  $('.datepicker').datepicker({
    autoclose: true,
    language: 'pt-BR',
    format: 'dd/mm/yyyy',
    forceParse: false
  });
});