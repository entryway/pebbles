jQuery(document).ready(function() {
  jQuery("#category-list").sortable({ 
    items: 'li', 
    placeholder: 'ui-state-highlight',
    update: function(event, ui) {
      jQuery('#category-list').load(
        '/admin/categories/' + jQuery(ui.item).attr('id') + '/reorder',
        {
          _method: 'PUT',
          parent: jQuery(ui.item).parent().attr('id'),
          right: jQuery(ui.item).next().attr('id') 
        }
      );
    }
  });
})
