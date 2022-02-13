

console.log("OK0");


(function() {
  // limits the number of categories
  ('.materials').on('cocoon:after-insert', function() {
    check_to_hide_or_show_add_link();
  });
console.log("OK1");
  ('.materials').on('cocoon:after-remove', function() {
    check_to_hide_or_show_add_link();
  });
console.log("OK2");
  check_to_hide_or_show_add_link();
console.log("OK3");
  function check_to_hide_or_show_add_link() {
    if (('.materials').length == 3) {
      ('a.btn.btn-secondary.btn-block.add_fields').hide();
    } else {
      ('a.btn.btn-secondary.btn-block.add_fields').show();
    }
  }
  console.log("OK4");
})

