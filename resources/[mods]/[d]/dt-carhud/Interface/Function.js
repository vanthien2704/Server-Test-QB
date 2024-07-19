
function closeMain() {
    $("body").css("display", "none");

}

function openMain() {
    $("body").css("display", "block");

}




window.addEventListener('message', function (event) {

    var item = event.data;

    var hasBelt = event.data.hasBelt,
        beltOn = event.data.beltOn,
        light = event.data.light,  
        SpeedLimit = event.data.SpeedLimit,  
        streetName = event.data.streetName

    
    var bs = document.getElementById("Sound");
    bs.value = 0.8;


    this.document.querySelector('.placeName').innerHTML = '<i class="fa-duotone fa-map-marker-alt"></i> ' + streetName;
    $("#header").css("transform", "scale(" + item.scale + ") ");


    if (hasBelt) {
        this.document.getElementById('belt').style.display = ""
    } else {
        this.document.getElementById('belt').style.display = "none"
    }

    if (beltOn && hasBelt) {  
        $(".info").hide();
        $(".name").show();
        document.getElementById('belt').classList.add('active');
        bs.pause();
    } else if (!beltOn && hasBelt) {
        bs.play();
        $(".info").show();
        $(".name").hide();
        document.getElementById('belt').classList.remove('active');
    }

    if(light) {
        document.getElementById('headlights').classList.add('active');
    } else if(!light) {
        document.getElementById('headlights').classList.remove('active');
    }

    if(SpeedLimit) {
        document.getElementById('cruise').classList.add('active');
    } else if(!SpeedLimit) {
        document.getElementById('cruise').classList.remove('active');
    }


 
    if(item.class == "car"){
        $(".car").show();
        $(".motorbike").hide();
        $(".boat").hide();
        $(".helicopter").hide();
        $(".bike").hide();

        if (item.health <= 100 && item.health > 50 ) {
            $(".imgcar").css("background", 'url(img/car.png)');
            $(".imgcar").css("background-size", '100%');
            $(".imgcar").css("background-repeat", 'no-repeat, no-repeat');
            $(".imgcar").css("background-position", 'center');
            // $(".imgcar").css("filter", 'brightness(0) invert(1)');
        } else if (item.health <= 50 && item.health > 20) {
            $(".imgcar").css("background", 'url(img/car-y.png)');
            $(".imgcar").css("background-size", '100%');
            $(".imgcar").css("background-repeat", 'no-repeat, no-repeat');
            $(".imgcar").css("background-position", 'center');
            // $(".imgcar").css("filter", 'brightness(1) invert(0)');
        } else if (item.health <= 19) {
            $(".imgcar").css("background", 'url(img/carred.png)');
            $(".imgcar").css("background-size", '100%');
            $(".imgcar").css("background-repeat", 'no-repeat, no-repeat');
            $(".imgcar").css("background-position", 'center');
            // $(".imgcar").css("filter", 'brightness(1) invert(0)');    
        }
    } else if(item.class == "motor"){
        $(".car").hide();
        $(".motorbike").show();
        $(".boat").hide();
        $(".helicopter").hide();
        $(".bike").hide();

        if (item.health <= 100 && item.health > 50 ) {
            $(".imgmotor").css("background", 'url(img/motorbike.png)');
            $(".imgmotor").css("background-size", '110%');
            $(".imgmotor").css("background-repeat", 'no-repeat, no-repeat');
            $(".imgmotor").css("background-position", 'center');
            $(".imgmotor").css("filter", 'brightness(0) invert(1)');
        } else if (item.health <= 50 && item.health > 20) {
            $(".imgmotor").css("background", 'url(img/motorbike-y.png)');
            $(".imgmotor").css("background-size", '110%');
            $(".imgmotor").css("background-repeat", 'no-repeat, no-repeat');
            $(".imgmotor").css("background-position", 'center');
            $(".imgmotor").css("filter", 'brightness(1) invert(0)');
        } else if (item.health <= 19) {
            $(".imgmotor").css("background", 'url(img/motorbike.png)');
            $(".imgmotor").css("background-size", '110%');
            $(".imgmotor").css("background-repeat", 'no-repeat, no-repeat');
            $(".imgmotor").css("background-position", 'center');
            $(".imgmotor").css("filter", 'brightness(1) invert(0)');    
        }

    } else if(item.class == "boat"){
        $(".car").hide();
        $(".motorbike").hide();
        $(".boat").show();
        $(".helicopter").hide();
        $(".bike").hide();

        if (item.health <= 100 && item.health > 50 ) {

            $(".boat").css("background", 'url(img/boat.png)');
            $(".boat").css("background-size", '110%');
            $(".boat").css("background-repeat", 'no-repeat, no-repeat');
            $(".boat").css("background-position", 'center');
            $(".boat").css("filter", 'brightness(0) invert(1)');


        } else if (item.health <= 50 && item.health > 20) {
            $(".boat").css("background", 'url(img/boat-y.png)');
            $(".boat").css("background-size", '110%');
            $(".boat").css("background-repeat", 'no-repeat, no-repeat');
            $(".boat").css("background-position", 'center');
            $(".boat").css("filter", 'brightness(1) invert(0)');

        } else if (item.health <= 19) {
            $(".boat").css("background", 'url(img/boat.png)');
            $(".boat").css("background-size", '110%');
            $(".boat").css("background-repeat", 'no-repeat, no-repeat');
            $(".boat").css("background-position", 'center');
            $(".boat").css("filter", 'brightness(1) invert(0)');

        }
    } else if(item.class == "helicopter"){
        $(".car").hide();
        $(".motorbike").hide();
        $(".boat").hide();
        $(".helicopter").show();
        $(".bike").hide();
        

        if (item.health <= 100 && item.health > 50 ) {

            $(".helicopter").css("background", 'url(img/helicopter.png)');
            $(".helicopter").css("background-size", '100%');
            $(".helicopter").css("background-repeat", 'no-repeat, no-repeat');
            $(".helicopter").css("background-position", 'center');
            $(".helicopter").css("filter", 'brightness(0) invert(1)');

        } else if (item.health <= 50 && item.health > 20) {
            $(".helicopter").css("background", 'url(img/helicopter-y.png)');
            $(".helicopter").css("background-size", '100%');
            $(".helicopter").css("background-repeat", 'no-repeat, no-repeat');
            $(".helicopter").css("background-position", 'center');
            $(".helicopter").css("filter", 'brightness(1) invert(0)');

        } else if (item.health <= 19) {
            $(".helicopter").css("background", 'url(img/helicopter.png)');
            $(".helicopter").css("background-size", '100%');
            $(".helicopter").css("background-repeat", 'no-repeat, no-repeat');
            $(".helicopter").css("background-position", 'center');
            $(".helicopter").css("filter", 'brightness(1) invert(0)');

        }
    }  else if(item.class == "bike"){
        $(".car").hide();
        $(".motorbike").hide();
        $(".boat").hide();
        $(".helicopter").hide();
        $(".bike").show();
        
        

        if (item.health <= 100 && item.health > 50 ) {

            $(".bike").css("background", 'url(img/bike.png)');
            $(".bike").css("background-size", '110%');
            $(".bike").css("background-repeat", 'no-repeat, no-repeat');
            $(".bike").css("background-position", 'center');


        } else if (item.health <= 50 && item.health > 20) {
            $(".bike").css("background", 'url(img/bike-y.png)');
            $(".bike").css("background-size", '110%');
            $(".bike").css("background-repeat", 'no-repeat, no-repeat');
            $(".bike").css("background-position", 'center');

        } else if (item.health <= 19) {
            $(".bike").css("background", 'url(img/bike.png)');
            $(".bike").css("background-size", '110%');
            $(".bike").css("background-repeat", 'no-repeat, no-repeat');
            $(".bike").css("background-position", 'center');

        }
    }


    
    if (item.w1 == "acc") {
        $('#wheel2').attr('src','img/wheel_pink.png');
    }else if(item.w1 == "die") {
        $('#wheel2').attr('src','img/wheel_red.png');
    }else if(item.w1 == "som") {
        $('#wheel2').attr('src','img/wheel.png');
    }
    if (item.w2 == "acc") {
        $('#wheel').attr('src','img/wheel_pink.png');
    }else if(item.w2 == "die") {
        $('#wheel').attr('src','img/wheel_red.png');
    }else if(item.w2 == "som") {
        $('#wheel').attr('src','img/wheel.png');
    }
    if (item.w3 == "acc") {
        $('#wheel3').attr('src','img/wheel_pink.png');
    }else if(item.w3 == "die") {
        $('#wheel3').attr('src','img/wheel_red.png');
    }else if(item.w3 == "som") {
        $('#wheel3').attr('src','img/wheel.png');
    }
    if (item.w4 == "acc") {
        $('#wheel4').attr('src','img/wheel_pink.png');
    }else if(item.w4 == "die") {
        $('#wheel4').attr('src','img/wheel_red.png');
    }else if(item.w4 == "som") {
        $('#wheel4').attr('src','img/wheel.png');
    }

    if (item.w1 == "acc") {
        $('#wheel1').css('background', 'yellow')
        $('#motorbike_wheel1').css('background', 'yellow')

    } else if (item.w1 == "die") {
        $('#wheel1').css('background', 'red')
        $('#motorbike_wheel1').css('background', 'red')


    } else {
        $('#wheel1').css('background', 'white')
        $('#motorbike_wheel1').css('background', 'white')

    }
    // ล้อหน้าขวา
    if (item.w2 == "acc") {
        $('#wheel3').css('background', 'yellow')
    } else if (item.w2 == "die") {
        $('#wheel3').css('background', 'red')

    } else {
        $('#wheel3').css('background', 'white')
    }
    // ล้อหลังซ้าย
    if (item.w3 == "acc") {
        $('#wheel2').css('background', 'yellow')
        $('#motorbike_wheel2').css('background', 'yellow')

    } else if (item.w3 == "die") {
        $('#wheel2').css('background', 'red')
        $('#motorbike_wheel2').css('background', 'red')

    } else {
        $('#wheel2').css('background', 'white')
        $('#motorbike_wheel2').css('background', 'white')

    }
    // ล้อหลังขวา
    if (item.w4 == "acc") {
        $('#wheel4').css('background', 'yellow')
    } else if (item.w4 == "die") {
        $('#wheel4').css('background', 'red')

    } else {
        $('#wheel4').css('background', 'white')
    }




    if (item.message == "show") {
        openMain();
        $(".percent-fuel").css("width", (item.fuel) + "%");
        $(".engine-percent").html("<i class='fa-duotone fa-engine'></i> "+ Math.round(item.engineHealth)   + "%");
        $(".percent-engin").css("height", item.engineHealth   + "%");
        // $(".gear").html(Math.round(item.gear));
        item.gear == 0 ? $('.gear').text("R") : $('.gear').text(item.gear)
        $(".speed").html(Math.round(item.speed) );
        $(".name").html(" <i class='fa-solid fa-magnifying-glass'></i> "+item.carname);
        $(".rpmroundtext").html(item.rpm*1000);
    }

    if (item.message == "hide") {
        bs.pause();
        closeMain();
    }

    if (event.data.Class == "playSound") {

        audioPlayer = new Audio("./Sound/" + event.data.FileName + ".ogg");
        audioPlayer.volume = event.data.Volume;
        audioPlayer.play();
    }


});