(function($) {                                                         
  $(document).ready(function(){                                        
    $('.delivery_status').change( function() {      
        $this = $(this);        
      $this.spin();                                                  
      var order_id = $this.prev('input:hidden').val();               
      $.ajax({                                                         
        type: 'PUT',                                                   
        url: '../admin/orders/' + order_id + '/change_delivery_status',
        dataType: 'text',                                              
        data: {                                                        
          delivery_status: $this.val(),                              
          order_id: order_id                                           
        },                                                             
        success: function(data) {                                      
          $this.unspin();                                                 
        }                                                           
      })                                                               
    });                                                                
  });                                                                  
})(jQuery);

