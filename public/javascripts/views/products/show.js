jQuery(document).ready(function() {
  jQuery(".selection-select").change(function() {
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
                       jQuery('#submit_button').hide();
                     }
                     else {
                      jQuery('#so_sorry_out_of_stock').hide();
                      jQuery('#submit_button').show();
                     }
                   }
    );
  });
})