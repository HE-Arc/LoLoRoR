
var ready;
var loaded = false;
ready = function() {
  if(loaded == false){
    loaded = true;
    function toggle_details(id)
    {
      alert("toggled: "+ id);
      $("#"+id).toggle();
      return false;
    }
    $('.details').hide();
    $('.btn-details-history').off('click');
    $(document).on('click','.btn-details-history', function(){
      $(this).parent().parent().parent().find('.details').toggle();
    });
  }
}



$(document).ready(ready);
$(document).on('page:load', ready);
$(document).on('page:change', ready);