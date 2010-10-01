
Event.addBehavior({
  	'#confirm_button input:click': function(e) {
		// show please wait button, disable confirmation button
		Element.hide('confirm_button');
		$('confirm_button').disabled = true;
		Element.show('please_wait');
	}
})