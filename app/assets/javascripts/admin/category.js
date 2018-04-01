var category = {
  initialize: function (){
    $('.btn-add-category').on('click', function(event){
      event.preventDefault();
      $("#category-modal").modal();
    });

    $(".btn-edit-category").each(function(){
      $(this).on('click', function(event){
        event.preventDefault();
        var id = $(this).attr('id');
        $("#category-modal-"+id).modal();
      });
    });
  }
}
