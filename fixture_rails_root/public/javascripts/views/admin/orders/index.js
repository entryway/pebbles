(function($) {
  $(document).ready(function(){
    $('.delivery_status').change( function() {
      $(this).spin();
      var order_id = $(this).prev('input:hidden').val();
      $.post(
        '../admin/orders/change_delivery_status',
        {
          delivery_status: $(this).val(),
          order_id: order_id
        },
        function(data) {
         $('.spinner').hide();
        }
      )
    });
  });
})(jQuery);