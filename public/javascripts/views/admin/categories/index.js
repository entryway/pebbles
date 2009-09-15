$(document).ready(function() {
  $("#category-list").sortable({ 
    items: 'li', 
    placeholder: 'ui-state-highlight',
    update: function(event, ui) {
      $('#category-list').load(
        '/admin/categories/reorder',
        {
          id: $(ui.item).attr('id'),
          parent: $(ui.item).parent().attr('id'),
          right: $(ui.item).next().attr('id') 
        }
      );
    }
  });
});
