jQuery(document).ready(function() {
  jQuery(".add-object").click(function() {
    jQuery(this).hide().parent("td").parent("tr").next("tr").show();
    return false;
  });
  var product_image_options = {
    target: "#images"
  }

  jQuery(".set_primary_image").livequery(function() {
    jQuery(this).submit(function() {
      jQuery(this).ajaxSubmit(product_image_options);
      return false;
    })
  });

  jQuery('#product_image_add').livequery( function() {
    jQuery(this).submit(function() {
      jQuery(this).ajaxSubmit(product_image_options);
      return false;
    })
  });
  jQuery('.edit-product-image').live('click', function() {
    jQuery(this).nextAll('div.change-image').show();
    return false;
  });
  jQuery('#product_image_edit').livequery( function() {
    jQuery(this).submit(function() {
      jQuery(this).ajaxSubmit(product_image_options);
      return false;
    })
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
      jQuery("#images").load(jQuery(this).attr('href'), { _method: "DELETE" });
    }
    return false;
  });
  jQuery(".destroy-product-image-thumbnail").live("click", function() {
    if (confirm( "Are you sure you want to remove the thumbnail?")) {
      jQuery("#images").load(jQuery(this).attr('href'), { _method: "DELETE" });
    }
    return false;
  });
  jQuery(".destroy-product-large-image").live("click", function() {
    if (confirm( "Are you sure you want to remove the large image?")) {
      jQuery("#images").load(jQuery(this).attr('href'), { _method: "DELETE" });
    }
    return false;
  });
  jQuery(".variant_image_upload").livequery("click", function() {
    jQuery("#variant_image").load("../admin/variant_images/new", function() {
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
  jQuery(".remove-variant-image").live("click", function() {
    if (confirm( "Are you sure you want to remove the variant image?")) {
      jQuery("#variants").load(jQuery(this).attr('href'), { _method: "DELETE" });
    }
    return false;
  });

  jQuery("#add_category").live("click", function() {
    var selected_category = parseInt(jQuery("#category_select").val());
    var category_ids = eval(jQuery("#category_ids").val() || []);
    var href = jQuery(this).attr('href');
    category_ids.push(selected_category);
    jQuery("#category_list").load(href, {'product[category_ids][]': category_ids,
    _method: 'PUT'});
    return false;
  });

  jQuery(".remove_category").live("click", function() {
    var category_to_remove = parseInt(jQuery(this).next("input:hidden").val());
    var category_ids = eval(jQuery("#category_ids").val());
    var href = jQuery(this).attr('href');
    var category_index = category_ids.indexOf(category_to_remove);
    category_ids.splice(category_index, 1);
    if (category_ids == "") {
      category_ids = [""];
    }
    jQuery("#category_list").load(href, {'product[category_ids][]': category_ids,
    _method: 'PUT'});
    return false;
  });

});
