jQuery(document).ready(function() {
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
    jQuery.getJSON("/variants/1?product_id=" + product_id + "&selection_ids=" + selection_ids, 
                   function(data){
                     jQuery('#price').html(data.price);
                     if (data.out_of_stock) {
                       jQuery('#so_sorry_out_of_stock').show();
                       jQuery('#submit_button').attr('disabled', 'disabled'); 
                     }
                     else {
                      jQuery('#so_sorry_out_of_stock').hide();
                      jQuery('#submit_button').removeAttr('disabled');
                     }
                   }
    );
  });
  jQuery('#variant_images').load('/variant_images?product_id=' + jQuery("#product_id").val());
  jQuery('.thumbnail').hover( 
    function() {
      jQuery('#variant_image').load('/variant_images/' + jQuery(this).attr('id'), 
        function() {
          jQuery(this).show();
        });
      jQuery('#product_image').hide();    
    },
    function() {
      jQuery('#variant_image').hide();
      jQuery('#product_image').show();
    }
  );
})