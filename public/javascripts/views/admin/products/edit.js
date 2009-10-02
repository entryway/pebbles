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
  jQuery('.image_thumbnail_add').livequery( function() {
    jQuery(this).submit(function() { 
      jQuery(this).ajaxSubmit(product_image_options); 
      return false; 
    })
  });
  jQuery('.image_large_add').livequery( function() {
    jQuery(this).submit(function() { 
      jQuery(this).ajaxSubmit(product_image_options); 
      return false; 
    })
  });
  jQuery(".destroy-product-image").live("click", function() {
    if (confirm( "Are you sure you want to remove the image?")) {
      jQuery("#image_list").load(jQuery(this).attr('href'), { _method: "DELETE" });
    }
    return false;
  });
  jQuery(".destroy-product-image-thumbnail").live("click", function() {
    if (confirm( "Are you sure you want to remove the thumbnail?")) {
      jQuery("#image_list").load(jQuery(this).attr('href'), { _method: "DELETE" });
    }
    return false;
  });
  jQuery(".destroy-product-large-image").live("click", function() {
    if (confirm( "Are you sure you want to remove the large image?")) {
      jQuery("#image_list").load(jQuery(this).attr('href'), { _method: "DELETE" });
    }
    return false;
  });
  jQuery(".variant_image_upload").livequery("click", function() {
    jQuery("#variant_image").load("/admin/variant_images/new", function() {
      var variant_ids = [];
      jQuery(".variant_image_upload:checked").each( function() {
        variant_ids.push(jQuery(this).val());
      });
      jQuery("#variant_ids").val(variant_ids);
    });
  });
  jQuery("#variant_image_add").livequery('submit', function() {    
    var variant_image_options = {
      target: "#variants"
    }
    jQuery(this).ajaxSubmit(variant_image_options); 
    return false;
  });
  jQuery(".destroy-variant-image").live("click", function() {
    if (confirm( "Are you sure you want to remove the variant image?")) {
      jQuery("#variants").load(jQuery(this).attr('href'), { _method: "DELETE" });
    }
    return false;
  });
  jQuery(".destroy-variant-large-image").live("click", function() {
    if (confirm( "Are you sure you want to remove the large image?")) {
      jQuery("#variant_large_image").load(jQuery(this).attr('href'), { _method: "DELETE" });
    }
    return false;
  });
  jQuery('#variant_image_large_add').livequery( function() {
    jQuery(this).submit(function() { 
      jQuery(this).ajaxSubmit({target: "#variant_large_image"}); 
      return false; 
    })
  });
  jQuery(".destroy-variant-thumbnail").live("click", function() {
    if (confirm( "Are you sure you want to remove the large image?")) {
      jQuery("#variant_thumbnail").load(jQuery(this).attr('href'), { _method: "DELETE" });
    }
    return false;
  });
  jQuery('#variant_thumbnail_add').livequery( function() {
    jQuery(this).submit(function() { 
      jQuery(this).ajaxSubmit({target: "#variant_thumbnail"}); 
      return false; 
    })
  });
  jQuery('.show-variant-image').livequery('click', function() {
    jQuery('#variant_image').load(jQuery(this).attr('href'));
    return false;
  });
})