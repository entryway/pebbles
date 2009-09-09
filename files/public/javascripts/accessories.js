// var Spinner = Behavior.create({
//   initialize: function() {
//    element = this.element;
//   },
// 
//   onsubmit: Event.delegate({
// 	'form.accessory_update' : function(e) { Remote.Form ({
// 	   onLoading: function() { $('spinner_' + element.id ).show(); },
// 	   onComplete: function() { Event.addBehavior.reload(); }
// 	}) }
//   })
// });

Event.addBehavior({
  	'#category_selector:change': function(e) { 
	  new Ajax.Request( $('category_selection_form').action,
	                  { onComplete: function() { Event.addBehavior.reload(); }, 
		                method: 'get', 
		                parameters: $('category_selection_form').serialize(true) });
	},
	'#add_accessory_link:click': function(e) {
	  new Ajax.Updater( 'accessories', $('add_accessory_link').href,
	                    { onComplete: function() { Event.addBehavior.reload(); },
	                      method: 'post', parameters: $('product_selector').serialize(true)});
	  return false;
	},

	'form.accessory_update:submit' : function() {
	    var id = this.id;
	    var action = this.action
	    new Ajax.Updater( 'accessories', action, 
	                     { parameters: $(id).serialize(true),
		                   method: 'put',
						   onLoading: function() { $('spinner_' + id ).show(); },
						   onComplete: function() { Event.addBehavior.reload(); }
						 }); 
		return false;
	  },
	 
	'.accessory_destroy:click': function(){
	  //we can use the id of the product_accessory's form to build the id of the spinner
	  var id = this.up('form').id;
      var href = this.href
  	  new Ajax.Updater( 'accessories', href,
	                    { onLoading: function() { $('spinner_' + id ).show(); },
		                  onComplete: function() { Event.addBehavior.reload(); },
	                      method: 'delete'});
	  return false;
   	}
});