
CalculateShipping = function() {
  //the zipcode text field only shows when a zipcode has not been entered; we can use this to flag whether to 
  //bother recalculating or not
  var zipcode = $('zipcode');
  if (!zipcode) {
	  new Ajax.Updater( 'shipping', '/shippings',
	                  { onLoading: function() { $('shipping_quote').hide(); $('shipping_spinner').show(); },
                    	onComplete: function() { Event.addBehavior.reload(); }, 
		                method: 'post', 
		                parameters: $('product').serialize(true) });
  }
  
};
ValidZipcode =  function() {
  var match = /^\d{5}([\-]\d{4})?$|^([A-Z]\d[A-Z]\s\d[A-Z]\d)$/.test($('zipcode').value)
  return match;
};

  Event.addBehavior({
   	'#shipping_quote:click' : function(e) { 
  	  if (!ValidZipcode()) {
  	    $('invalid_zipcode_error').show();
  	    $('zipcode').focus();
  	  }
  	  else {
 	      new Ajax.Updater( 'shipping', $('shipping_quote_link').href,
      	                  { onLoading: function() { $('zipcode').hide(); $('shipping_quote').hide(); 
      	                                            $('shipping_spinner').show(); },
                          	onComplete: function() { Event.addBehavior.reload(); }, 
      		                method: 'post', 
      		                parameters: $('product').serialize(true) });
    	}
	  return false;
   	},
	'#quantity:change' : function(e) { CalculateShipping(); },
	'.shipping:change' : function(e) { CalculateShipping(); },
	
  '#product_options:change' : function() {
	  new Ajax.Updater('button', '/products/check_out_of_stock', { parameters: $('options[]').serialize(true)});},
  '#submit_button:click' : function() {
    if ($('zipcode')) {
      $('zipcode_error').show();
      return false;
    }
    
  }
});
Event.onReady(function() { $('zipcode').focus(); });