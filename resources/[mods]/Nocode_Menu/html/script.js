var setting1 = true, setting2 = true, setting3 = true, setting4 = true , setting5 = true ,setting6 = true;
var select1 = true, select2 = true, select3 = true, select4 = true , select5 = true , select6 = true;
var selectCheck2 = 'one', selectCheck3 = 'one';

window.addEventListener('message', function (event) {
    switch (event.data.action) {
        case 'openUi':

        $('#display').fadeIn(200);
        $('#first-page').fadeIn(100);
        $('#second-pag').fadeOut(100);
        $('#weather-data-box').hide(0);
        $('#time-data-box').hide(0);
        $('#fps-topic').show(0);
        $('#weather-topic').hide(0);
        $('#time-topic').hide(0);

        $('.item').on('click', function () {
            var id = $(this).attr('id');
            $.post('https://Nocode_Menu/action', JSON.stringify({
                action: id,
            }));
        });

        $('#boost').on('click', function(){
            if(setting1) {
                setting1 = false
                if (select1) {
                    select1 = false
                    $('#boost').css('background-color', 'rgb(115, 175, 115)');
                    $.post('https://Nocode_Menu/action', JSON.stringify({
                        action: 'boostOn',
                    }));
                    setTimeout(function(){
                        setting1 = true
                    }, 0);
                } else {
                    select1 = true
                    $('#boost').css('background-color', 'rgb(78, 78, 78)');
                    $.post('https://Nocode_Menu/action', JSON.stringify({
                        action: 'boostOff',
                    }));
                    setTimeout(function(){
                        setting1 = true
                    }, 0);
                }
            }
        });

        $('#fashion').on('click', function(){
            if(setting2) {
                setting2 = false
                if (selectCheck2 === 'one') {
                    select2 = false
                    selectCheck2 = 'two'
                    $('#fashion').css('background-color', 'rgb(115, 175, 115)');
                    $.post('https://Nocode_Menu/action', JSON.stringify({
                        action: 'fashionOn',
                    }));
                    setTimeout(function(){
                        setting2 = true
                    }, 0);
                } else if (selectCheck2 === 'two') {
                    select2 = false
                    selectCheck2 = 'three'
                    $('#fashion').css('background-color', 'rgb(184, 184, 133)');
                    $.post('https://Nocode_Menu/action', JSON.stringify({
                        action: 'otherFashionOn',
                    }));
                    setTimeout(function(){
                        setting2 = true
                    }, 0);
                } else if (selectCheck2 === 'three') {
                    select2 = true
                    selectCheck2 = 'one'
                    $('#fashion').css('background-color', 'rgb(78, 78, 78)');
                    $.post('https://Nocode_Menu/action', JSON.stringify({
                        action: 'fashionOff',
                    }));
                    setTimeout(function(){
                        setting2 = true
                    }, 0);
                };
            }
        });

        $('#effect').on('click', function(){
            if(setting3) {
                setting3 = false
                if (selectCheck3 === 'one') {
                    select3 = false
                    selectCheck3 = 'two'
                    $('#effect').css('background-color', 'rgb(115, 175, 115)');
                    $.post('https://Nocode_Menu/action', JSON.stringify({
                        action: 'effectOn',
                    }));
                    setTimeout(function(){
                        setting3 = true
                    }, 0);
                } else if (selectCheck3 === 'two') {
                    select3 = false
                    selectCheck3 = 'three'
                    $('#effect').css('background-color', 'rgb(184, 184, 133)');
                    $.post('https://Nocode_Menu/action', JSON.stringify({
                        action: 'otherEffectOn',
                    }));
                    setTimeout(function(){
                        setting3 = true
                    }, 0);
                } else if (selectCheck3 === 'three') {
                    select3 = true
                    selectCheck3 = 'one'
                    $('#effect').css('background-color', 'rgb(78, 78, 78)');
                    $.post('https://Nocode_Menu/action', JSON.stringify({
                        action: 'effectOff',
                    }));
                    setTimeout(function(){
                        setting3 = true
                    }, 0);
                };
            }
        });

        $('#blood').on('click', function(){
            if(setting4) {
                setting4 = false
                if (select4) {
                    select4 = false
                    $('#blood').css('background-color', 'rgb(115, 175, 115)');
                    $.post('https://Nocode_Menu/action', JSON.stringify({
                        action: 'bloodOn',
                    }));
                    setTimeout(function(){
                        setting4 = true
                    }, 0);
                } else {
                    select4 = true
                    $('#blood').css('background-color', 'rgb(78, 78, 78)');
                    $.post('https://Nocode_Menu/action', JSON.stringify({
                        action: 'bloodOff',
                    }));
                    setTimeout(function(){
                        setting4 = true
                    }, 0);
                }
            }
        });

        $('#killfeed').on('click', function(){
            if(setting5) {
                setting5 = false
                if (select5) {
                    select5 = false
                    $('#killfeed').css('background-color', 'rgb(115, 175, 115)');
                    $.post('https://Nocode_Menu/action', JSON.stringify({
                        action: 'KillfeedOn',
                    }));
                    setTimeout(function(){
                        setting5 = true
                    }, 0);
                } else {
                    select5 = true
                    $('#killfeed').css('background-color', 'rgb(78, 78, 78)');
                    $.post('https://Nocode_Menu/action', JSON.stringify({
                        action: 'KillfeedOff',
                    }));
                    setTimeout(function(){
                        setting5 = true
                    }, 0);
                }
            }
        });

        $('#chat').on('click', function(){
            if(setting6) {
                setting6 = false
                if (select6) {
                    select6 = false
                    $('#chat').css('background-color', 'rgb(115, 175, 115)');
                    $.post('https://Nocode_Menu/action', JSON.stringify({
                        action: 'Chaton',
                    }));
                    setTimeout(function(){
                        setting6 = true
                    }, 0);
                } else {
                    select6 = true
                    $('#chat').css('background-color', 'rgb(78, 78, 78)');
                    $.post('https://Nocode_Menu/action', JSON.stringify({
                        action: 'Chatoff',
                    }));
                    setTimeout(function(){
                        setting6 = true
                    }, 0);
                }
            }
        });

        $('#boost').hover(
            function () {
              if (select1) {
                $(this).css('background-color', 'rgb(99, 130, 150)');
              }
            },
            function () {
              if (select1) {
                $(this).css('background-color', 'rgb(78, 78, 78)');
              }
            }
        );

        $('#fashion').hover(
            function () {
              if (select2) {
                $(this).css('background-color', 'rgb(99, 130, 150)');
              }
            },
            function () {
              if (select2) {
                $(this).css('background-color', 'rgb(78, 78, 78)');
              }
            }
        );

        $('#effect').hover(
            function () {
              if (select3) {
                $(this).css('background-color', 'rgb(99, 130, 150)');
              }
            },
            function () {
              if (select3) {
                $(this).css('background-color', 'rgb(78, 78, 78)');
              }
            }
        );

        $('#blood').hover(
            function () {
              if (select4) {
                $(this).css('background-color', 'rgb(99, 130, 150)');
              }
            },
            function () {
              if (select4) {
                $(this).css('background-color', 'rgb(78, 78, 78)');
              }
            }
        );

        $('#killfeed').hover(
            function () {
              if (select5) {
                $(this).css('background-color', 'rgb(99, 130, 150)');
              }
            },
            function () {
              if (select5) {
                $(this).css('background-color', 'rgb(78, 78, 78)');
              }
            }
        );

        $('#chat').hover(
            function () {
              if (select6) {
                $(this).css('background-color', 'rgb(99, 130, 150)');
              }
            },
            function () {
              if (select6) {
                $(this).css('background-color', 'rgb(78, 78, 78)');
              }
            }
        );

        $('#go-first-page').on('click', function () {
            $('#first-page').fadeIn(100);
            $('#second-pag').fadeOut(100);
            $('#weather-data-box').fadeOut(100);
            $('#time-data-box').fadeOut(100);
            $('#fps-topic').show(0);
            $('#weather-topic').hide(0);
            $('#time-topic').hide(0);
        });

        $('#go-second-page').on('click', function () {
            $('#first-page').fadeOut(100);
            $('#second-pag').fadeIn(100);
            $('#weather-data-box').fadeIn(100);
            $('#time-data-box').fadeOut(100);
            $('#fps-topic').hide(0);
            $('#weather-topic').show(0);
            $('#time-topic').hide(0);
        });

        $('#TIME').on('click', function () {
            $('#weather-data-box').fadeOut(100);
            $('#time-data-box').fadeIn(100);
            $('#weather-topic').hide(0);
            $('#time-topic').show(0);
            $('#time-data-box').css('display', 'flex');
        });

        $('#WEATHER').on('click', function () {
            $('#time-data-box').fadeOut(100);
            $('#weather-data-box').fadeIn(100);
            $('#weather-topic').show(0);
            $('#time-topic').hide(0);
        });

        document.onkeyup = function (data) {
            if (data.which == 27) {
                $('#display').fadeOut(200);
                $.post('https://Nocode_Menu/action', JSON.stringify({
                    action: 'close',
                }
                ));
            }
        };

        break
    }
});