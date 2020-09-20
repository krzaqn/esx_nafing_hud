window.addEventListener("message", function (event) {
  switch (event.data.action) {
    case "hud":
      Progress(event.data.health, ".health");
      Progress(event.data.armor, ".armor");
      Progress(event.data.thirst, ".thirst");
      Progress(event.data.hunger, ".hunger");
      break;
    case "showui":
      $("body").fadeIn();
      break;
    case "hideui":
      $("body").fadeOut();
      break;
    case "voice-color":
      Progress(event.data.isTalking, ".voiceon");
      break;
    case "voice":
      if (event.data.prox === 0) {
        $("#voiceshout").fadeIn();
        $("#voicenormal").fadeIn();
        $("#voicewhisper").fadeIn();
      } else if (event.data.prox === 1) {
        $("#voicenormal").fadeIn();
        $("#voiceshout").fadeOut();
        $("#voicewhisper").fadeIn();
      } else if (event.data.prox === 2) {
        $("#voicewhisper").fadeIn();
        $("#voicenormal").fadeOut();
        $("#voiceshout").fadeOut();
      }
      break;
    case "car":
      if (event.data.showhud == true) {
        $(".hudCar").fadeIn();
        setProgressSpeed(event.data.speed, ".progress-speed");
        setProgressFuel(event.data.fuel, ".progress-fuel");
      } else {
        $(".hudCar").fadeOut();
      }
      break;
  }
});

function Progress(percent, element) {
  var circle = document.querySelector(element);
  var radius = circle.r.baseVal.value;
  var circumference = radius * 2 * Math.PI;
  var html = $(element).parent().parent().find("span");

  circle.style.strokeDasharray = `${circumference} ${circumference}`;
  circle.style.strokeDashoffset = `${circumference}`;

  const offset = circumference - ((-percent * 100) / 100 / 100) * circumference;
  circle.style.strokeDashoffset = -offset;

  html.text(Math.round(percent));
}

function setProgressSpeed(value, element) {
  var circle = document.querySelector(element);
  var radius = circle.r.baseVal.value;
  var circumference = radius * 2 * Math.PI;
  var html = $(element).parent().parent().find("span");
  var percent = (value * 100) / 220;

  circle.style.strokeDasharray = `${circumference} ${circumference}`;
  circle.style.strokeDashoffset = `${circumference}`;

  const offset = circumference - ((-percent * 73) / 100 / 100) * circumference;
  circle.style.strokeDashoffset = -offset;

  var speed = Math.floor(value * 1.8);
  if (speed == 81 || speed == 131) {
    speed = speed - 1;
  }

  html.text(speed);
}

function setProgressFuel(percent, element) {
  var circle = document.querySelector(element);
  var radius = circle.r.baseVal.value;
  var circumference = radius * 2 * Math.PI;
  var html = $(element).parent().parent().find("span");

  circle.style.strokeDasharray = `${circumference} ${circumference}`;
  circle.style.strokeDashoffset = `${circumference}`;

  const offset = circumference - ((-percent * 73) / 100 / 100) * circumference;
  circle.style.strokeDashoffset = -offset;

  html.text(Math.round(percent));
}
