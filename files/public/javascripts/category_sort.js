$(document).ready(
  function () {
    $('#category-list').sortable({items:'.category_item',
				  revert: true,
				  update: function() {
				    $.post('/admin/categories/reorder', '_method:put&authenticity_token='+AUTH_TOKEN+'&'+$(this).sortable('serialize'));
				  }
				 });
  });
