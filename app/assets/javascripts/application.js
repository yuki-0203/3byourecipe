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
//= require jquery
//= require rails-ujs
//= require turbolinks
//= require_tree .

// require jquery3
//= require popper
//= require bootstrap-sprockets
//= require cocoon

//レシピフォームのcoccon制限
$(function() {
  // limits the number of categories
  $('#materials').on('cocoon:after-insert', function() {
    check_to_hide_or_show_add_link();
  });

  $('#materials').on('cocoon:after-remove', function() {
    check_to_hide_or_show_add_link();
  });

  check_to_hide_or_show_add_link();

  function check_to_hide_or_show_add_link() {
    if ($('.material-label:visible').length == 8) {
      $('#add-material a.btn-sm.btn-info.col-1.text-center.add_fields').hide();
    } else {
      $('#add-material a.btn-sm.btn-info.col-1.text-center.add_fields').show();
    }
  }
})

$(function() {
  // limits the number of categories
  $('#steps').on('cocoon:after-insert', function() {
    check_to_hide_or_show_add_link();
  });

  $('#steps').on('cocoon:after-remove', function() {
    check_to_hide_or_show_add_link();
  });

  check_to_hide_or_show_add_link();

  function check_to_hide_or_show_add_link() {
    if ($('.step-label:visible').length == 5) {
      $('a.btn-sm.btn-info.col-1.text-center.add_fields').hide();
    } else {
      $('a.btn-sm.btn-info.col-1.text-center.add_fields').show();
    }
  }
})
