var RandomKeys = [1,2,3,4,5,6,7,8,9]
var answer;
var minigamebar = new ProgressBar.Line('.minigame-bar', {color: '#1e476b',strokeWidth: 5,trailColor: 'transparent',trailWidth: 5});

BeginGame = function(){
    minigamebar.set(0)
    $('.main').css({display:'flex',opacity:0}).animate({opacity:1})
    var keys = []
    var attempt = []
    $('.main-number,.attempted-number').html('')
    $('.blocks').each(function(){
        var key = RandomKeys[RandomKeys.length*Math.random()<<0]
        $(this).html(`<span data-hiddenkey='${key}' class="block-number">${key}</span>`)
        setTimeout(function(){
            $('.main').find(`[data-hiddenkey=${key}]`).animate({'font-size':0},500).parent().off().click(function(){
                attempt.push(key)
                AnswerUpdate(attempt)
                $('.attempted-number').append(key)
                $.post(`https://${GetParentResourceName()}/PlaySound`)
            })
        },2000)
        keys.push(key) 
    })
    answer = GetRandomNumberFromString(keys)
    setTimeout(function(){
        minigamebar.animate(1.0,{duration:5000},function(){
            $.post(`https://${GetParentResourceName()}/MiniGameResult`,JSON.stringify({won:false}))
            $('.main').fadeOut()
        });
        $('.main-number').html(answer)
    },2100)
}

AnswerUpdate = function(array){
    if (array.length == 4){
        if (array.join('') == answer){
            $.post(`https://${GetParentResourceName()}/MiniGameResult`,JSON.stringify({won:true}))
        }else{
            $.post(`https://${GetParentResourceName()}/MiniGameResult`,JSON.stringify({won:false}))
            $('.error').fadeIn(100).fadeOut(300)
        }
        $('.main').fadeOut()
        minigamebar.stop()
    }
}

GetRandomNumberFromString = function(keys){
    var length = 4;
    var result           = [];
    var characters       = keys.join('')
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {result.push(characters.charAt(Math.floor(Math.random()*charactersLength)));}
    return result.join('');
}

addEventListener('message',function(event){
    var data = event.data 
    if (data.action == 'minigame'){
        BeginGame()
    }
})