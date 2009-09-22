jQuery(document).ready(function() {
  jQuery(".add-selection").click(function() {
    jQuery(this).hide().parent("td").parent("tr").next("tr").show();
    return false;
  });
})