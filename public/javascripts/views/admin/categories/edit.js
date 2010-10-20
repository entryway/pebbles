jQuery(document).ready(function() {

  var category_image_options = { 
    target: "#image_list" 
  }
  jQuery('#category_image_add').livequery('submit', function() { 
    jQuery(this).ajaxSubmit(category_image_options); 
    return false; 
  });

  jQuery(".destroy-category-image").live("click", function() {
    if (confirm( "Are you sure you want to remove the image?")) {
      jQuery("#image_list").load(jQuery(this).attr('href'), { _method: "DELETE" });
    }
    return false;
  })
  
  jQuery('#category_icon_add').livequery('submit', function() { 
    jQuery(this).ajaxSubmit({ target: "#category_icon"}); 
    return false; 
  });

  jQuery(".destroy-category-icon").live("click", function() {
    if (confirm( "Are you sure you want to remove the icon?")) {
      jQuery("#category_icon").load(jQuery(this).attr('href'), { _method: "DELETE" });
    }
    return false;
  })
  
  jQuery('#category_icon_hover_add').livequery('submit',function() { 
    jQuery(this).ajaxSubmit({ target: "#icon_hover"}); 
    return false; 
  });

  jQuery("#destroy-category-icon-hover").live("click", function() {
    if (confirm( "Are you sure you want to remove the icon hover?")) {
      jQuery("#icon_hover").load(jQuery(this).attr('href'), { _method: "DELETE" });
    }
    return false;
  })

})