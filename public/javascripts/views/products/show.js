jQuery(document).ready(function() {
  jQuery(".selection-select").change(function() {
    var product_id = jQuery("#product_id").val();
    var selection_ids = [];
    jQuery(".selection-select").each(function(item) {
      selection_ids.push(this.value);
    });
    jQuery("#price").load("/variants/1?product_id=" + product_id + "&selection_ids=" + selection_ids);
  });
})