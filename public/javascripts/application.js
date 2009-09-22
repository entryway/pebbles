// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


// This module is javascript specific to the ordering process

jQuery.noConflict(true);

function payment_credit_card_details_show()
{
	Element.toggle('paypal_details');
	Effect.Appear('credit_card_details');
	Effect.Appear('billing_shipping_info')
	Effect.toggle('credit_card_button');
	return true;
}

function payment_credit_card_details_hide()
{
	Element.toggle('credit_card_details');
	Element.toggle('billing_shipping_info');
	Effect.Appear('paypal_details');
	Element.toggle('credit_card_button');
	return  true;
}

var ImageRollover = Behavior.create({
  orig_name: null,    // the filename without extension
  image_ext: null,    // jpg, gif, etc, plus any ?123 nonsense at the end
  roll_suffix: null,  // whatever we want to stick on the end of the image name

  // one of these instances of ImageRollover will be created for each image 
  // when we set them up, we'll need to know the "suffix" of the rolled over image
  // for example, home.gif might be our image and home_on.gif might be our 
  // rollover, making '_on' our suffix
  initialize: function(roll_suffix) {
    this.roll_suffix = roll_suffix

    // here comes some lovely regex
    // image.src example: http://example.com/images/something.gif?1234567890
    // we need to chop that up into: 
    // 'http://example.com/images/something' and '.gif?1234567890' 
    matches = this.element.src.match(/(.*)((?:.gif|.jpg|.png).*)/);
    this.orig_name = matches[1]; 
    this.image_ext = matches[2];
  },

  // this function will get called on mouseover
  onmouseover: function() {
    // we're just stapling the pieces back together with the suffix between 
    // the file name and the file extension 
    this.element.src = this.orig_name + this.roll_suffix + this.image_ext
  },
  
  onmouseout: function() {
    // back to the original, no suffix
    this.element.src = this.orig_name + this.image_ext
  }
});


Event.addBehavior({
  	'.button input': ImageRollover('-hover'),
  	'.button img': ImageRollover('-hover')
})