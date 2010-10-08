$(document).ready(function() {
  $('#category-list').sortable({ 
    items: 'li', 
    placeholder: 'ui-state-highlight',
    forcePlaceholderSize: 'true',
    update: function(event, ui) {
      $('#category-list').load(
        '../admin/categories/' + $(ui.item).attr('id') + '/reorder',
        {
          _method: 'PUT',
          parent: $(ui.item).parent().attr('id'),
          right: $(ui.item).next().attr('id') 
        }
      );
    }
  });
});
