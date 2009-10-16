(function($) { 
  $(document).ready(function(){
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