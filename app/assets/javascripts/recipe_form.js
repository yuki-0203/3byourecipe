(function() {
  // limits the number of categories
  ('#materials').on('cocoon:after-insert', function() {
    check_to_hide_or_show_add_link();
  });

  ('#materials').on('cocoon:after-remove', function() {
    check_to_hide_or_show_add_link();
  });

  check_to_hide_or_show_add_link();

  function check_to_hide_or_show_add_link() {
    if (('#materials.nested-fields.material-label:visible').length == 2) {
      ('#add-material.a').hide();
    } else {
      ('#add-material.a').show();
    }
  }
})