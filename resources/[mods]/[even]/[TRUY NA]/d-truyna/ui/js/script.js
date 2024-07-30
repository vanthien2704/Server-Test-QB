// Biến cờ để kiểm tra xem âm thanh đã được phát hay chưa
var audioPlayed = false;

window.addEventListener('message', function(e) {
    var data = e.data;

    if (data.openui) {
        fadeInBody();
        document.getElementById('money').innerHTML = data.money;
        document.getElementById('name').innerHTML = data.name;
        document.getElementById('text').innerHTML = data.reason;
        document.getElementById('time').innerHTML = `${data.time}S`;
        document.getElementById('Bounty_IMG').src = data.Profile;

        // Kiểm tra xem âm thanh đã được phát hay chưa
        if (!audioPlayed) {
            var audio = document.getElementById('myAudio');
            if (audio) {
                // Kiểm tra xem âm thanh không đang phát và phát âm thanh
                if (audio.paused || audio.ended) {
                    audio.play();
                    audioPlayed = true; // Đặt biến cờ là đã phát âm thanh
                }
            } else {
                console.error('Phần tử audio không tồn tại.');
            }
        }

    } else {
        fadeOutBody();

        // Phát âm thanh khi UI đóng lại (nếu cần)
        var audio2 = document.getElementById('myAudio2');
        if (audio2) {
            // Kiểm tra xem âm thanh không đang phát và phát âm thanh
            if (audio2.paused || audio2.ended) {
                audio2.play();
            }
        } else {
            console.error('Phần tử audio không tồn tại.');
        }

        // Đặt lại biến cờ khi UI đóng lại
        audioPlayed = false;
    }

    if (data.eventclose) {
        fadeOutBody();
    }

    if (data.playerdead) {
        setGrayscale(1);
    } else {
        setGrayscale(0);
    }
});

function fadeInBody() {
    var body = document.body;
    if (body) {
        body.style.display = 'block'; // Thiết lập hiển thị block để fadeIn hoạt động
    }
}

function fadeOutBody() {
    var body = document.body;
    if (body) {
        body.style.display = 'none'; // Ẩn body để fadeOut hoạt động
    }
}

function setGrayscale(value) {
    var bountyContainer = document.getElementById('Bounty_Container');
    if (bountyContainer) {
        bountyContainer.style.filter = `grayscale(${value})`;
    }
}
