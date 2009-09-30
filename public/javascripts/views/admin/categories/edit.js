jQuery(document).ready(function() {

  var category_image_options = { 
    target: "#image_list" 
  }
  jQuery('#category_image_add').submit(function() { 
    jQuery(this).ajaxSubmit(category_image_options); 
    return false; 
  });

  jQuery(".destroy-category-image").live("click", function() {
    if (confirm( "Are you sure you want to remove the image?")) {
      jQuery("#image_list").load(jQuery(this).attr('href'), { _method: "DELETE" });
    }
    return false;
  })

})