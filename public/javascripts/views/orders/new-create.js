function ShowHideShipping() {
  if ($("#address_choice:checked").size() == 0) {
    $("#shipping_address_fields").show();
  } else {
    $("#shipping_address_fields").hide();
  }
}
(function($) { 
  $.postJSON = function(url, data, callback) {
    $.post( url, data, callback, "json") ;
  };  

  $(document).ready(function(){
    $('#order_form').validate();
    $('#promo_code_link').click(function() {
      $.postJSON(
        $(this).attr('href'),
        { promo_code: $('#promo_text_field').val() },
        function(json) {
          $('#promo_code_message').html(json.promo_code_message).effect("highlight", {}, 3000);
          $('#promo_code_note').html(json.promo_code_note).effect("highlight", {}, 3000);
          $('#shipping_total').html(json.shipping_total);
          $('#cart_total').html(json.grand_total);
          if (json.no_tax) {
            $('#tax_row').hide();
          } else {
            $('#tax_row').show();
            $('#tax_total').html(json.tax_total)
          }
        }
      );
      return false;
    });
    
    $('#billing_address_state').change(function() {
      var billing_state = $(this).val();
      $.postJSON(
        "/taxes/1",
        { billing_state: billing_state, _method: "PUT"}, 
        function(json){
          if (json.no_tax) {
            $('#tax_row').hide();
          } else {
            $('#tax_row').show();
            $('#tax_total').html(json.tax_total)
          }
          $('#cart_total').html(json.grand_total);
        }
      );
    })
    $('#confirm_link').click(function() {
      $(this).spin();
    });
  $('#methods').livequery('change', function() {
      $(this).spin();
      $.postJSON("/regions/1/shipping_methods/" + $(this).val(),
                 { _method: "PUT"}, 
                 function(json){
                   $('#shipping_total').html(json.shipping_total);
                   $('#cart_total').html(json.grand_total);
                   $('.spinner').hide();
                 }
      );
    });
    ShowHideShipping();
    $("#address_choice").click( function() {
      ShowHideShipping();
    });
  });
})(jQuery);