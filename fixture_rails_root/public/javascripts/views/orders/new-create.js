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
  $.validator.addMethod('zipcode', function(value){
    return /^\d{5}([\-]\d{4})?$|^([A-Z]\d[A-Z]\s\d[A-Z]\d)$/.test(value)
  },   'must be valid US zipcode (in the format "12345" or "12345-1234")');
  $.validator.addMethod('email', function(value){
    return /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/.test(value)
  },   'should be in the form of someone@somewhere.com');
  $.validator.addMethod("expirydate", function(value) {
           var result = true;
           var ccYear = parseInt($("#credit_card_year").val());
           var ccMonth = parseInt($("#credit_card_month").val());
           var datNow = new Date();
           var intMonth = datNow.getMonth()+1;
           var intYear = datNow.getFullYear()
           if (ccYear < intYear) { result = false; }
           if (ccMonth < intMonth && ccYear == intYear ) { result = false; }
           return result;
      }, "Card has already expired");

  $(document).ready(function(){
    $('#order_form').validate({
      invalidHandler: function() {
        $('.spinner').hide();
      },
      rules: {
        'shipping_address[address_1]': {
          required: function (element) { return $('#address_choice:checked').length == 0 }
        },
        'shipping_address[city]': {
          required: function (element) { return $('#address_choice:checked').length == 0 }
        },
        'shipping_address[state]': {
          required: function (element) { return $('#address_choice:checked').length == 0 }
        },
        'shipping_address[state]': {
          required: function (element) { return $('#address_choice:checked').length == 0 }
        },
        'shipping_address[postal_code]': {
          zipcode: {depends: function (element) { return $('#address_choice:checked').length == 0 }}
        },
        'credit_card[number]': {
          creditcard2: function(){ return $('#order_card_type').val(); }
        }
      }
    });
    if ($('#order_card_type').length == 0) {
      $('#credit_card_number').rules("remove", "creditcard2");
    }
    $('#promo_code_link').click(function() {
      $.postJSON(
        $(this).attr('href'),
        { promo_code: $('#promo_text_field').val() },
        function(json) {
          $('#promo_code_message').html(json.promo_code_message).effect("highlight", {}, 3000);
          $('#promo_code_note').html(json.promo_code_note).effect("highlight", {}, 3000);

          $('#shipping_total').html(json.shipping_total);
          $('#cart_total').html(json.grand_total);
          if (json.no_discount) {
            $('#discount').hide();
          } else {
            $('#discount_row').show();
            $('#discount').html(json.discount)
          }
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
      $('#what_is_link').live('click', function() {
          $('#what_is_this').toggle();
          return false;
      });


    $('#billing_address_state').change(function() {
      var billing_state = $(this).val();
      $.postJSON(
        "../taxes/1",
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
      $.postJSON("../regions/1/shipping_methods/" + $(this).val(),
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