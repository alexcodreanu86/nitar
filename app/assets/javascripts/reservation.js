function checkTripType(value){
  if(+value <= 4){
    airportTrip();
  } else if(+value == 5){
    pointToPoint()
  } else if(+value == 6){
    hourlyTrip();
  }
  checkFormElementStatus();
}


function checkFormElementStatus(){
  var elements = document.getElementsByClassName('required');
  for(var i = 0; i < elements.length; i ++){
    var element = elements[i];
    if (element.value == "" || +element.value == -1){
      element.className = "form-control required input-sm red-border"
    } else {
      element.className = "form-control required input-sm green-border"
    }
  }
}

function airportTrip(){
  $("#hours").hide();
  $('#airport').show();
  $('#airport-tax').show()
  $('#rate_id').show();
}

function hourlyTrip(){
  $('#airport').hide();
  $('#airport-tax').hide();
  $('#rate_id').hide();
  $('#hours').show();
}

function pointToPoint(){
  $('#airport').hide();
  $("#hours").hide();
  $('#airport-tax').hide()
  $('#rate_id').show();
}