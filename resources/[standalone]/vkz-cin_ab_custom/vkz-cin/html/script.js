let player;
const container = document.getElementById('video-container');
const stopBtn = document.getElementById('close-btn');
const volumeSlider = document.getElementById('volume-slider');
let storedVolume = localStorage.getItem("videoVolume") || 50;
volumeSlider.value = storedVolume;

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
            showinfo: 0,
            playsinline: 1,
            enablejsapi: 1
        },
        events: {
            'onReady': function(event){
                player.setVolume(storedVolume);
            },
            'onStateChange': onPlayerStateChange
        }
    });
}

// Bloquer totalement la mise en pause
function onPlayerStateChange(event) {
    if(event.data === YT.PlayerState.PAUSED) {
        player.playVideo();
    }
    if(event.data === YT.PlayerState.ENDED){
        closeVideo();
    }
}

// Jouer la vidéo
function playVideo(videoId){
    container.style.display = 'flex';
    if(player && player.loadVideoById){
        player.loadVideoById(videoId);
        player.setVolume(storedVolume);
        fetch(`https://${GetParentResourceName()}/focusNUI`, {
            method: 'POST',
            body: JSON.stringify({ focus: true })
        });
    }
}

// Fermer la vidéo
function closeVideo(){
    container.style.display = 'none';
    if(player) player.stopVideo();
    fetch(`https://${GetParentResourceName()}/focusNUI`, {
        method: 'POST',
        body: JSON.stringify({ focus: false })
    });
}

// Ajuster volume immédiatement
volumeSlider.oninput = function(){
    let vol = parseInt(this.value);
    localStorage.setItem('videoVolume', vol);
    if(player) player.setVolume(vol);
}

// Stop bouton individuel
stopBtn.onclick = closeVideo;

// Écoute les événements serveur
window.addEventListener('message', function(event){
    if(event.data.type === 'playVideo'){
        playVideo(event.data.videoId);
    } else if(event.data.type === 'closeVideo'){
        closeVideo();
    }
});
