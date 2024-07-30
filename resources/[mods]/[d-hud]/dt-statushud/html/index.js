$(document).ready(function () {
  window.addEventListener('message', function (event) {
    var data = event.data;
    var health = data.health;
    var armor = data.armor;
    var myhunger = data.myhunger;
    var mywater = data.mywater;
    var mybrain = data.mybrain;
    var stamina = data.stamina;
    var oxy = data.myoxy;
    var id = data.my_id;
    if (data.show == true) {
      $("body").fadeIn();
      Progress(data.myhunger, ".food")
      Progress(data.mywater, ".water")
      Progress(data.stamina, ".run")
      Progress(data.mybrain, ".brain")
      Progress(data.myoxy, ".oxy")

      $("#id").html(Math.round(id));


      $("#health").css("width", data.health + "%");
      $("#armor").css("width", data.armor + "%");
      $("#hunger").css("height", data.myhunger + "%");
      $("#thirst").css("height", data.water + "%");
      $("#stamina").css("width", data.stamina + "%");
      $("#stress").css("height", data.mybrain + "%");
      $("#oxy").css("height", data.myoxy + "%");

      if (data.food < 20) {
        $("#hunger").css("height", data.food + "%");
        $(".food").css("animation", "blickon 2s infinite");
      } else if (data.food > 20) {
        $("#hunger").css("height", data.food + "%");
        $(".food").css("animation", "blickoff 2s infinite");
      }

      if (data.water < 20) {
        $("#thirst").css("height", data.water + "%");
        $(".bath").css("animation", "blickon 2s infinite");
      } else if (data.water > 20) {
        $("#thirst").css("height", data.water + "%");
        $(".bath").css("animation", "blickoff 2s infinite");
      }

      if (data.brain < 20) {
        $("#energy").css("height", data.brain + "%");
        $(".brain").css("animation", "blickon 2s infinite");
      } else if (data.brain > 20) {
        $("#energy").css("height", data.brain + "%");
        $(".brain").css("animation", "blickoff 2s infinite");
      }

      if (health <= 0) {
        $("#thealth").html("0HP");
      } else {
        $("#thealth").html(Math.round(health) + "HP");
      }
      $("#tarmor").html(Math.round(armor) + "%");
      $("#tstamina").html(Math.round(stamina));
      $("#thunger").html(Math.round(myhunger));
      $("#tthirst").html(Math.round(mywater));
      $("#tstress").html(Math.round(mybrain));
      $("#toxy").html(Math.round(oxy));
    } else {
      $("body").fadeOut();
    }
  })
})

function Progress(percent, element) {
  var circle = document.querySelector(element);
  var radius = circle.r.baseVal.value;
  var circumference = radius * 2 * Math.PI;

  circle.style.strokeDasharray = `${circumference} ${circumference}`;
  circle.style.strokeDashoffset = `${circumference}`;

  const offset = circumference - ((-percent * 100) / 100 / 100) * circumference;
  circle.style.strokeDashoffset = -offset;
}

function Progress(percent, element) {
  var circle2 = document.querySelector(element);
  var radius = circle2.r.baseVal.value;
  var circumference = radius * 2 * Math.PI;

  circle2.style.strokeDasharray = `${circumference} ${circumference}`;
  circle2.style.strokeDashoffset = `${circumference}`;

  const offset = circumference - ((-percent * 100) / 100 / 100) * circumference;
  circle2.style.strokeDashoffset = -offset;
}

