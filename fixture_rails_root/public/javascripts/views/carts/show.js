(function($) { 
  $.postJSON = function(url, data, callback) {
    $.post( url, data, callback, "json") ;
  };  

  $(document).ready(function(){
    $('#regions').change( function() {
      $(this).spin();
      $('#shipping_info').load("/regions/" + $('#regions').val() + "/shipping_methods",
                               function() { $('.spinner').hide(); }); 
    });
    $('#methods').livequery('change', function() {
      $(this).spin();
      $.postJSON("/regions/" + $('#regions').val() + "/shipping_methods/" + $(this).val(),
                 { _method: "PUT"}, 
                 function(json){
                   $('#shipping_total').html(json.shipping_total);
                   $('#cart_total').html(json.grand_total);
                   $('.spinner').hide();
                 }
      );

    });
    $.validator.addClassRules("quantity", {
      digits: true,
      min: 1
    });
    $('#cart_form').validate();
    
  });

})(jQuery);