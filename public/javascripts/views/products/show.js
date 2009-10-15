jQuery(document).ready(function() {
  jQuery.validator.addMethod('inventory', function(value){
    return (jQuery('#inventory').length == 0 || parseInt(value) <= parseInt(jQuery('#inventory').val()));
  },   'sorry there are only ' + jQuery('#inventory').val() + ' left');
  jQuery('#cart_item_form').validate({ 
    rules: {
      '#quantity': "inventory"}});
  var current_variant_id = null;
  jQuery("#submit_button").click(function() {
    var invalid = false;
    jQuery(".selection-select").each(function(item) {
      if (this.value == "") {
        invalid = true;
        jQuery(this).next(".error_message").show();
      }
    });
    if (invalid) {
      return false;
    }  
  });
  jQuery(".selection-select").change(function() {
    jQuery(this).next(".error_message").hide();
    var product_id = jQuery("#product_id").val();
    var selection_ids = [];
    jQuery(".selection-select").each(function(item) {
      selection_ids.push(this.value);
    });
    jQuery.getJSON("../../../variants/1?product_id=" + product_id + "&selection_ids=" + selection_ids, 
                   function(data){
                     current_variant_id = data.variant_image_id;
                     jQuery('#price').html(data.price);
                     jQuery('#variant_images div:visible').hide();
                     if (current_variant_id != null) {
                       jQuery('#variant_images').show();
                       jQuery('#variant_image_' + current_variant_id).show();
                       jQuery('#product_image').hide();
                     }
                     if (data.out_of_stock || data.inventory == 0) {
                       jQuery('#so_sorry_out_of_stock').show();
                       jQuery('#submit_button').attr('disabled', 'disabled'); 
                     }
                     else {
                      jQuery('#so_sorry_out_of_stock').hide();
                      jQuery('#submit_button').removeAttr('disabled');
                     }
                     if (jQuery('#inventory').length > 0) {
                       jQuery('#quantity').rules("remove", "inventory");
                       jQuery('#inventory').val(data.inventory);
                       jQuery('#quantity').rules("add", { 
                         "inventory": true, 
                         messages: {
                           inventory: 'sorry there is only ' + jQuery('#inventory').val() + ' left'
                         }
                       });
                     }
                   }
    );
  });
  jQuery('#variant_images').load('../../../variant_images?product_id=' + jQuery("#product_id").val());
  jQuery('.thumbnail').hover( 
    function() {
        if(current_variant_id != null) {
            jQuery('#variant_image_' + current_variant_id).hide();           
        } else {
            jQuery('#product_image').hide();   
        }
        jQuery('#variant_images').show();
        jQuery('#variant_image_' + jQuery(this).attr('id')).show();
    },
    function() {
      jQuery('#variant_images').hide();
      jQuery('#variant_image_' + jQuery(this).attr('id')).hide();
        if(current_variant_id != null) {
            jQuery('#variant_images').show();
            jQuery('#variant_image_' + current_variant_id).show();           
        } else {
            jQuery('#product_image').show();   
        }
    }
  );
})