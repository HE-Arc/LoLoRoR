$(document).on('page:change', function() {
  function toggle_details(id)
  {
    alert("toggled: "+ id);
    $("#"+id).toggle();
    return false;
  }
  
  
  $('.details').toggle();
  $(document).on('click','.btn-details-history', function(){
    
    $(this).parent().parent().parent().find('.details').toggle();
    
    
  });
});