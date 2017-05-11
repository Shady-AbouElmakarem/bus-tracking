$(document).ready(function(){
  $("#add_location").click(function(){
      $("#add_location").parent().before('<div class="form-group"> \
        <label class="control-label col-md-2"></label></label> \
        <div class="input-group col-md-9"> \
          <span class="input-group-addon"><i class="fa fa-map-signs"></i></span> \
          <input  name="locations[]" placeholder="Location Name" class="form-control"  type="text"> \
          <span class="input-group-addon"><i class="glyphicon glyphicon-map-marker"></i></span> \
          <input  name="locations[]" placeholder="Latitude" class="form-control"  type="text"> \
          <span class="input-group-addon"><i class="glyphicon glyphicon-map-marker"></i></span> \
          <input  name="locations[]" placeholder="Longitude" class="form-control"  type="text"> \
          <span class="input-group-addon btn trash"><i class="glyphicon glyphicon-trash	"></i></span> \
        </div> \
      </div>');
  });

});
$(document).on("click",".trash", function(){
  $(this).parent().parent().remove();
});
