let player;
const container = document.getElementById('video-container');
const stopBtn = document.getElementById('close-btn');
const volumeSlider = document.getElementById('volume-slider');

// Volume sauvegardé
let storedVolume = localStorage.getItem("videoVolume") || 50;
storedVolume = parseInt(storedVolume);
volumeSlider.value = storedVolume;

// Caché au start
container.style.display = 'none';

// YouTube API prête
function onYouTubeIframeAPIReady() {
    player = new YT.Player('youtube-player', {
        height: '100%',
        width: '100%',
        videoId: '',
        playerVars: {
            autoplay: 1,
            controls: 0,
            disablekb: 1,
            fs: 0,
            modestbranding: 1,
            iv_load_policy: 3,
            rel: 0,
            playsinline: 1,
            enablejsapi: 1
        },
        events: {
            onReady: function () {
                player.setVolume(storedVolume);
            },
            onStateChange: onPlayerStateChange
        }
    });
}

// Empêche pause + gère fin
function onPlayerStateChange(event) {
    if (event.data === YT.PlayerState.PAUSED) {
        player.playVideo();
    }

    if (event.data === YT.PlayerState.ENDED) {
        closeVideo();
    }
}

// Jouer vidéo
function playVideo(videoId) {
    container.style.display = 'flex';

    if (player && player.loadVideoById) {
        player.loadVideoById(videoId);
        player.setVolume(storedVolume);
    }

    // Focus NUI
    fetch(`https://${GetParentResourceName()}/focusNUI`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ focus: true })
    });
}

// Fermer vidéo
function closeVideo() {
    container.style.display = 'none';

    if (player) {
        player.stopVideo();
    }

    fetch(`https://${GetParentResourceName()}/focusNUI`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ focus: false })
    });
}

// Volume en live
volumeSlider.addEventListener('input', function () {
    let vol = parseInt(this.value);

    localStorage.setItem('videoVolume', vol);

    if (player) {
        player.setVolume(vol);
    }
});

// Bouton fermer
stopBtn.addEventListener('click', closeVideo);

// ESC pour fermer (important UX FiveM)
document.addEventListener('keydown', function (e) {
    if (e.key === "Escape") {
        closeVideo();
    }
});

// Events depuis Lua
window.addEventListener('message', function (event) {
    if (event.data.type === 'playVideo') {
        playVideo(event.data.videoId);
    }

    if (event.data.type === 'closeVideo') {
        closeVideo();
    }
});