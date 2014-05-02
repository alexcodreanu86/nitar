function displayPrice(price){
  $(".price-response").html("<h1>" + price + "$</h1>")
}

function clearPrice(){
  $(".price-response").empty();
  $('#generator-button').addClass("hidden")
}

function setSelection(selection ,element){
  checker[selection] = Number(element.value);
  checker.checkFormStatus();
}

function typeSelection(choice){
  var result = Number(choice.value)
  checker.tripType = result;

  if (result > 4){
    $("#airport").fadeOut(200);

    if (result == 6){
      $("#city_id").hide();
      $("#hours").show();
    } else {
      $("#city_id").show();
      $("#hours").hide();
    }

  } else if (result > 0) {
    $("#airport").show(170);
    $("#city_id").show();
    $("#hours").hide();

  }
  checker.checkFormStatus();
}

function FormChecker(){
  this.tripType;
  this.airport;
  this.cityId;
  this.carType;
  this.hours;

  var self = this;
  this.checkFormStatus = function(){
    if (checkHourlyFields()){
      getQuote("/rates/hourly_quote");
      showButton();
    } else if(checkRestOfFields()) {
      getQuote("/rates/calculate");
      showButton();
    } else {
      clearPrice();
    }
  }

  function showButton(){
    $('#generator-button').removeClass("hidden")
  }

  var checkRestOfFields = function(){
    var result = false;
    if (checkAirportRequest()){
      result = true;
    } else if(self.tripType == 5 && self.cityId > 0 && self.carType > 0 ) {
      result = true;
    }
    return result;
  }

  var checkAirportRequest = function(){
    return (self.tripType <= 4 && self.tripType > 0 && self.cityId > 0 && self.carType > 0 && self.airport > 0)
  }

  var checkHourlyFields = function(){
    return (self.tripType == 6 && self.carType > 0 && self.hours > 1)
  }

  var getQuote = function(url){
    var data = $("#instant-quote").serialize()
    $.get(url, data, function(response){
      displayPrice(response.price);
    })
  }
}