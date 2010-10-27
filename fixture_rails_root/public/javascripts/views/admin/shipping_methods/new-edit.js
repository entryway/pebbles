jQuery(document).ready(function() {
  jQuery(".add-object").click(function() {
    jQuery(this).hide().parent("td").parent("tr").next("tr").show();
    return false;
  });
})