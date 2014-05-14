function checkTripType(value){
  if(+value <= 4){
    airportTrip(+value);
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

function airportTrip(value){
  $("#hours").hide();
  $('#airport').show();
  $('#rate_id').show();
  if(value == 4){
    $('#airport-tax').hide();
    updateInput('trip_drop_off', "e.g. AA 170")
    updateInput('trip_pick_up')
  } else {
    $('#airport-tax').show();
    updateInput('trip_pick_up', "e.g. AA 170")
    updateInput('trip_drop_off')
  }
}

function updateInput(element, newText){
  if (newText){
    document.getElementById(element).placeholder = newText
    updateLabel(element, "Flight information")
  } else {
    document.getElementById(element).placeholder = "e.g. 1 S. Dearbord Chicago IL 60001"
    if (element == "trip_drop_off"){
      var text = "Drop off Address";
    } else {
      var text = "Pick up Address";
    }
    updateLabel(element, text)
  }

}

function updateLabel(element, text){
  document.getElementById(element).parentNode.firstChild.firstChild.innerText = text
}

function nonAirportTrip(){
  updateInput('trip_pick_up')
  updateLabel('trip_pick_up', "Pick up Address")
  updateInput('trip_drop_off')
  updateLabel('trip_drop_off', "Drop off Address")
}

function hourlyTrip(){
  $('#airport').hide();
  $('#airport-tax').hide();
  $('#rate_id').hide();
  $('#hours').show();
  nonAirportTrip()
}

function pointToPoint(){
  $('#airport').hide();
  $("#hours").hide();
  $('#airport-tax').hide()
  $('#rate_id').show();
  nonAirportTrip()
}