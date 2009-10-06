function ShowHideShipping() {
  if ($("#address_choice:checked").size() == 0) {
    $("#shipping_address_fields").show();
  } else {
    $("#shipping_address_fields").hide();
  }
}
(function($) { 
  $(document).ready(function(){
    ShowHideShipping();
    $("#address_choice").click( function() {
      ShowHideShipping();
    });
  });
})(jQuery);