Event.addBehavior({
  	'#print-packing-sheet:click': function(e) {
		$('logo').show();
		window.print();
		$('logo').hide();
		return false;
	},
	'#print-gift-receipt:click': function(e) {
		$('logo').show();
		$('price-header').hide();
		$('total-header').hide();
		$$('td.price-value').each(function(element) {
      		element.hide();
      	});
		$$('td.total-value').each(function(element) {
      		element.hide();
      	});
		$('totals').hide();
		window.print();
		$('price-header').show();
		$('total-header').show();
		$$('td.price-value').each(function(element) {
      		element.show();
      	});
		$$('td.total-value').each(function(element) {
      		element.show();
      	});
		$('totals').show();
		$('logo').hide();
		return false;
	}
})