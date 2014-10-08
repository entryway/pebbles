(function($) {
  $(document).ready(function(){
      $('#post_authorize_link').click(function() {
          var order_total = $('#post_authorize_amount').val();
          $('#order_transactions').load($(this).attr('href'), { _method: 'put', post_authorize_amount: order_total},
                                        $(this).hide());
          return false;
      });
    $('#print-packing-sheet').click( function() {
  		$('#logo').show();
  		window.print();
  		$('#logo').hide();
  		return false;
    });
    $('#print-gift-receipt').click( function() {
      $('#logo').show();
  		$('#price-header').hide();
  		$('#total-header').hide();
  		$('.price-value').hide();
  		$('.total-value').hide();
  		$('#totals').hide();
  		window.print();
  		$('#price-header').show();
  		$('#total-header').show();
  		$('.price-value').show();
  		$('.total-value').show();
  		$('#totals').show();
  		$('#logo').hide();
  		return false;
  	});
  });
})(jQuery);