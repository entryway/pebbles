jQuery(document).ready(function() {
  jQuery(".add-object").click(function() {
    jQuery(this).hide().parent("td").parent("tr").next("tr").show();
    return false;
  });
  var product_image_options = { 
    target: "#image_list" 
  }
  jQuery('#product_image_add').submit(function() { 
    jQuery(this).ajaxSubmit(product_image_options); 
    return false; 
  });
  jQuery('#image_thumbnail_add').submit(function() { 
    jQuery(this).ajaxSubmit(product_image_options); 
    return false; 
  });
  jQuery(".destroy-product-image").live("click", function() {
    if (confirm( "Are you sure you want to remove the image?")) {
      jQuery("#image_list").load(jQuery(this).attr('href'), { _method: "DELETE" });
    }
    return false;
  })
  jQuery(".destroy-product-image-thumbnail").live("click", function() {
    if (confirm( "Are you sure you want to remove the thumbnail?")) {
      jQuery("#image_list").load(jQuery(this).attr('href'), { _method: "DELETE" });
    }
    return false;
  })
})